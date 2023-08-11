import 'package:dartz/dartz.dart';
import 'package:todo_test/common/core/data/hive_model/hive_user.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/athentication/data/datasource/local_ds/user_local_datasource.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/login_request.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/signup_param.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

base class UserRepositoryImpl extends UserRepository {
  final UserLocalDatasource datasource;
  UserRepositoryImpl({required this.datasource});

  @override
  Either<Failure, UserEntity> isUserExist() {
    try {
      UserEntity user = datasource.isUserExist();
      return Right(user);
    } on Exception {
      return Left(Failure(message: 'User not exist.'));
    }
  }

  @override
  Future<Either<Failure, void>> signup(SignupRequest request) async {
    try {
      HiveUser hiveUser = HiveUser(
        request.firstname,
        request.lastname,
        request.username,
        request.password,
        true,
      );

      var signup = await datasource.addUser(hiveUser);
      return Right(signup);
    } on Exception {
      return Left(Failure(message: 'Somthing went wront.'));
    }
  }

  @override
  Future<Either<Failure, void>> login(LoginRequest param) async {
    try {
      var user = datasource.getUser();
      if (user.password == param.password) {
        user.isLogin = true;
        var login = await datasource.addUser(user.toDB(user));
        return Right(login);
      } else {
        return Left(Failure(message: 'Wrong password.'));
      }
    } on Exception {
      return Left(Failure(message: 'You do not have an account.'));
    }
  }

  @override
  Either<Failure, void> logout() {
    try {
      var user = datasource.getUser();
      user.isLogin = false;
      print(user.isLogin);
      return Right(datasource.addUser(user.toDB(user)));
    } on Exception {
      return Left(Failure(message: 'Try agane.'));
    }
  }
}

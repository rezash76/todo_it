import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/athentication/data/datasource/local_datasource/user_local_datasource.dart';
import 'package:todo_test/features/athentication/data/model/hive/hive_user.dart';
import 'package:todo_test/features/athentication/domain/entity/user_entity.dart';
import 'package:todo_test/features/athentication/domain/value_object/signin_request.dart';
import 'package:todo_test/features/athentication/domain/value_object/signup_request.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

base class UserRepositoryImpl extends UserRepository {
  final UserLocalDatasource datasource;
  UserRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, UserEntity>> isUserExist() async {
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
  Future<Either<Failure, void>> signin(SigninRequest request) async {
    try {
      var user = datasource.getUser();
      if (user.password == request.password) {
        user.isLogin = true;
        var signin = await datasource.addUser(user.toDB(user));
        return Right(signin);
      } else {
        return Left(Failure(message: 'Wrong password.'));
      }
    } on Exception {
      return Left(Failure(message: 'You do not have an account.'));
    }
  }

  @override
  Future<Either<Failure, void>> signout() async {
    try {
      var user = datasource.getUser();
      user.isLogin = false;
      var signout = await datasource.addUser(user.toDB(user));
      return Right(signout);
    } on Exception {
      return Left(Failure(message: 'Try agane.'));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/value_object/void_operation.dart';
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
    } on NotFound {
      return Left(NotFound());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> signup(SignupRequest request) async {
    try {
      HiveUser hiveUser = HiveUser(
        '',
        request.firstname,
        request.lastname,
        request.username,
        request.password,
        true,
      );

      await datasource.addUser(hiveUser);
      return Right(VoidOperation().voidValue);
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> signin(SigninRequest request) async {
    try {
      var user = datasource.getUser();
      if (user.password == request.password) {
        user.isLogin = true;
        await datasource.addUser(user.toDB(user));
        return Right(VoidOperation().voidValue);
      } else {
        return Left(WrongPassword());
      }
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> signout() async {
    try {
      var user = datasource.getUser();
      user.isLogin = false;
      await datasource.addUser(user.toDB(user));
      return Right(VoidOperation().voidValue);
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }
}

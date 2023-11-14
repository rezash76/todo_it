import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/failure.dart';
import 'package:todo_it/features/athentication/domain/entity/user_entity.dart';
import 'package:todo_it/features/athentication/domain/value_object/signin_request.dart';
import 'package:todo_it/features/athentication/domain/value_object/signup_request.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> isUserExist();
  Future<Either<Failure, void>> signup(SignupRequest request);
  Future<Either<Failure, void>> signin(SigninRequest request);
  Future<Either<Failure, void>> signout();
}

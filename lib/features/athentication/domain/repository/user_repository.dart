import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/signin_request.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/signup_param.dart';

abstract class UserRepository {
  Either<Failure, UserEntity> isUserExist();
  Future<Either<Failure, void>> signup(SignupRequest request);
  Future<Either<Failure, void>> signin(SigninRequest request);
  Either<Failure, void> signout();
}

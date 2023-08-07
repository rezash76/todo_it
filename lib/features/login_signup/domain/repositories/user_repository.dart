import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/login_signup/domain/entities/value_object/login_request.dart';
import 'package:todo_test/features/login_signup/domain/entities/value_object/signup_param.dart';

abstract class UserRepository {
  Either<Failure, UserEntity> isUserExist();
  Future<Either<Failure, void>> signup(SignupRequest request);
  Either<Failure, UserEntity> login(LoginRequest param);
  Either<Failure, void> logout();
}

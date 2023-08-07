import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/login_signup/domain/entities/value_object/login_request.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_test/features/login_signup/domain/repositories/user_repository.dart';

class LoginUsecase {
  final UserRepository repository;

  LoginUsecase({required this.repository});

  Either<Failure, UserEntity> call(LoginRequest param) =>
      repository.login(param);
}

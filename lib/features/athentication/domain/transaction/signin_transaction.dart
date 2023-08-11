import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/login_request.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

class SigninTransaction {
  final UserRepository repository;

  SigninTransaction({required this.repository});

  Either<Failure, UserEntity> call(LoginRequest param) =>
      repository.login(param);
}

import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/login_signup/domain/repositories/user_repository.dart';

base class SplashUsecase {
  final UserRepository repository;

  SplashUsecase(this.repository);

  Either<Failure, UserEntity> call() => repository.isUserExist();
}

import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

base class CheckRegistrationTransaction {
  final UserRepository repository;

  CheckRegistrationTransaction(this.repository);

  Either<Failure, UserEntity> call() => repository.isUserExist();
}

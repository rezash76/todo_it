import 'package:dartz/dartz.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';

base class GetUserDataUsecase {
  DrawerRepository repository;

  GetUserDataUsecase(this.repository);

  Either<Failure, UserEntity> call() => repository.getUserData();
}

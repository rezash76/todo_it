import 'package:dartz/dartz.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/common/error/failure.dart';

abstract interface class DrawerRepository {
  Either<Failure, UserEntity> getUserData();
  Either<Failure, int> getTheme();
  Future<Either<Failure, int>> setTheme(int themeMode);
}

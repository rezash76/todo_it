import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';

base class SetThemeUsecase {
  final DrawerRepository repository;

  SetThemeUsecase(this.repository);

  Future<Either<Failure, int>> call(int themeMode) =>
      repository.setTheme(themeMode);
}

import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';

base class GetThemeTransaction {
  final DrawerRepository repository;

  GetThemeTransaction(this.repository);

  Either<Failure, int> call() => repository.getTheme();
}

import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';
import 'package:todo_test/common/transaction/transaction.dart';

base class SetThemeTransaction implements Transaction<int, int> {
  final DrawerRepository repository;

  SetThemeTransaction(this.repository);

  @override
  Future<Either<CacheException, int>> call(int request) =>
      repository.setTheme(request);
}

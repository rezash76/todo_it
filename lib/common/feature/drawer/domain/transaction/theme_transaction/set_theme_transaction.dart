import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/feature/drawer/domain/repository/drawer_repository.dart';
import 'package:todo_it/common/transaction/transaction.dart';

base class SetThemeTransaction implements Transaction<int, int> {
  final DrawerRepository repository;

  SetThemeTransaction(this.repository);

  @override
  Future<Either<CacheException, int>> call(int request) async =>
      await repository.setTheme(request);
}

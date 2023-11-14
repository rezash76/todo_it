import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/feature/drawer/domain/repository/drawer_repository.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/common/value_object/no_request.dart';

base class GetThemeTransaction implements Transaction<int, NoRequest> {
  final DrawerRepository repository;

  GetThemeTransaction(this.repository);

  @override
  Future<Either<CacheException, int>> call(NoRequest request) async =>
      await repository.getTheme();
}

import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';

abstract interface class DrawerRepository {
  Future<Either<CacheException, int>> getTheme();
  Future<Either<CacheException, int>> setTheme(int request);
}

import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/feature/drawer/data/datasource/drawer_datasource.dart';
import 'package:todo_it/common/feature/drawer/domain/repository/drawer_repository.dart';

base class DrawerRepositoryImpl implements DrawerRepository {
  final DrawerDatasource datasource;

  DrawerRepositoryImpl(this.datasource);

  @override
  Future<Either<CacheException, int>> getTheme() async {
    try {
      int themeMode = datasource.getTheme();
      return Right(themeMode);
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    }
  }

  @override
  Future<Either<CacheException, int>> setTheme(int request) async {
    try {
      int theme = await datasource.setTheme(request);
      return Right(theme);
    } on NullValue {
      return Left(NullValue());
    }
  }
}

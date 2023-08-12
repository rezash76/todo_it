import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/feature/drawer/data/datasource/drawer_datasource.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';

base class DrawerRepositoryImpl implements DrawerRepository {
  final DrawerDatasource datasource;

  DrawerRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, int>> getTheme() async {
    try {
      int themeMode = datasource.getTheme();
      return Right(themeMode);
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong.'));
    }
  }

  @override
  Future<Either<Failure, int>> setTheme(int request) async {
    try {
      int theme = await datasource.setTheme(request);
      return Right(theme);
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong.'));
    }
  }
}

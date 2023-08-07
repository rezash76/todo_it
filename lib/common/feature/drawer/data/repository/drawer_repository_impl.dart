import 'package:dartz/dartz.dart';
import 'package:flutter/src/material/app.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/feature/drawer/data/datasource/drawer_datasource.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';

base class DrawerRepositoryImpl implements DrawerRepository {
  final DrawerDatasource datasource;

  DrawerRepositoryImpl(this.datasource);

  @override
  Either<Failure, UserEntity> getUserData() {
    try {
      final user = datasource.getUserData();
      return Right(user);
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong'));
    }
  }

  @override
  Either<Failure, ThemeMode> getTheme() {
    try {
      int themeMode = datasource.getTheme();
      return Right(_convertIntToThemeMode(themeMode));
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong.'));
    }
  }

  @override
  Future<Either<Failure, ThemeMode>> setTheme(ThemeMode themeMode) async {
    try {
      int theme = await datasource.setTheme(_convertThemeModeToInt(themeMode));
      return Right(_convertIntToThemeMode(theme));
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong.'));
    }
  }

  ThemeMode _convertIntToThemeMode(int value) {
    switch (value) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      case 2:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  int _convertThemeModeToInt(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 0;
      case ThemeMode.dark:
        return 1;
      case ThemeMode.system:
        return 2;
      default:
        return 2;
    }
  }
}

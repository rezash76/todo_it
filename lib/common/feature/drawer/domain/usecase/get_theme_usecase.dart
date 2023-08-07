import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';

base class GetThemeUsecase {
  final DrawerRepository repository;

  GetThemeUsecase(this.repository);

  Either<Failure, ThemeMode> call() => repository.getTheme();
}

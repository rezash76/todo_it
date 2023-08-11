import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/common/feature/drawer/domain/transaction/theme_transaction/get_theme_transaction.dart';
import 'package:todo_test/common/feature/drawer/domain/transaction/theme_transaction/set_theme_transaction.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final GetThemeTransaction getThemeUsecase;
  final SetThemeTransaction setThemeUsecase;

  DrawerBloc(
    this.getThemeUsecase,
    this.setThemeUsecase,
  ) : super(DrawerInitial()) {
    on<GetTheme>(_getThemeHandler);
    on<SetTheme>(_setThemeHandler);
  }

  _getThemeHandler(GetTheme event, Emitter emit) {
    var result = getThemeUsecase();
    result.fold(
      (failure) => emit(GetThemeError(failure.message)),
      (theme) {
        final themeMode = _convertIntToThemeMode(theme);
        emit(GetThemeSuccess(themeMode));
      },
    );
  }

  _setThemeHandler(SetTheme event, Emitter emit) async {
    final theme = _convertThemeModeToInt(event.themeMode);
    var result = await setThemeUsecase(theme);
    result.fold(
      (failure) => emit(GetThemeError(failure.message)),
      (theme) {
        final themeMode = _convertIntToThemeMode(theme);
        emit(GetThemeSuccess(themeMode));
      },
    );
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

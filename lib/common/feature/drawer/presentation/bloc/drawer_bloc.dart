import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/common/feature/drawer/domain/usecase/get_theme_usecase.dart';
import 'package:todo_test/common/feature/drawer/domain/usecase/get_user_data_usecase.dart';
import 'package:todo_test/common/feature/drawer/domain/usecase/set_theme_usecase.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final GetUserDataUsecase getUserDataUsecase;
  final GetThemeUsecase getThemeUsecase;
  final SetThemeUsecase setThemeUsecase;

  DrawerBloc(
      this.getUserDataUsecase, this.getThemeUsecase, this.setThemeUsecase)
      : super(DrawerInitial()) {
    on<GetUserDataEvent>(_getUserDataEventHandler);
    on<GetTheme>(_getThemeHandler);
    on<SetTheme>(_setThemeHandler);
  }

  _getUserDataEventHandler(GetUserDataEvent event, Emitter<DrawerState> emit) {
    final result = getUserDataUsecase();
    result.fold(
      (failure) => emit(DrawerGetUserDataError(failure.message)),
      (user) => emit(DrawerGetUserDataSuccess(user)),
    );
  }

  _getThemeHandler(GetTheme event, Emitter emit) {
    var isDarkTheme = getThemeUsecase();
    isDarkTheme.fold(
      (failure) => emit(GetThemeError(failure.message)),
      (themeMode) => emit(GetThemeSuccess(themeMode)),
    );
  }

  _setThemeHandler(SetTheme event, Emitter emit) async {
    var isDarkTheme = await setThemeUsecase(event.themeMode);
    isDarkTheme.fold(
      (failure) => emit(GetThemeError(failure.message)),
      (themeMode) => emit(GetThemeSuccess(themeMode)),
    );
  }
}

part of 'drawer_bloc.dart';

@immutable
sealed class DrawerState {}

final class DrawerInitial extends DrawerState {}

final class DrawerGetUserDataSuccess extends DrawerState {
  final UserEntity user;

  DrawerGetUserDataSuccess(this.user);
}

final class DrawerGetUserDataError extends DrawerState {
  final String message;

  DrawerGetUserDataError(this.message);
}

class GetThemeSuccess extends DrawerState {
  final ThemeMode themeMode;

  GetThemeSuccess(this.themeMode);
}

class GetThemeError extends DrawerState {
  final String message;

  GetThemeError(this.message);
}

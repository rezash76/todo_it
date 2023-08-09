part of 'drawer_bloc.dart';

@immutable
sealed class DrawerEvent {}

class GetTheme extends DrawerEvent {}

class SetTheme extends DrawerEvent {
  final ThemeMode themeMode;

  SetTheme(this.themeMode);
}

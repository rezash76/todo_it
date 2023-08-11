part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashSeccessUserExist extends SplashState {
  final UserEntity user;

  SplashSeccessUserExist(this.user);
}

class SplashErrorUserExist extends SplashState {
  final String message;

  SplashErrorUserExist(this.message);
}

class SplashLoading extends SplashState {}

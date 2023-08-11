part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninSuccess extends SigninState {}

class SigninError extends SigninState {
  final String message;
  SigninError(this.message);
}

class SignoutSuccess extends SigninState {}

class SignoutError extends SigninState {
  final String message;
  SignoutError(this.message);
}

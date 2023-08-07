part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SignInEvent extends LoginEvent {
  final LoginRequest param;
  SignInEvent({required this.param});
}

class LogoutEvent extends LoginEvent {}

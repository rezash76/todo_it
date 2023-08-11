part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class SignInEvent extends SigninEvent {
  final SigninRequest request;
  SignInEvent({required this.request});
}

class SignoutEvent extends SigninEvent {}

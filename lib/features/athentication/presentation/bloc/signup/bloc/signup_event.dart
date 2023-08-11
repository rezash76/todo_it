part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

base class Signup extends SignupEvent {
  final SignupRequest request;

  Signup({required this.request});
}

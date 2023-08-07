import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/login_signup/domain/repositories/user_repository.dart';
import '../entities/value_object/signup_param.dart';

base class SignupUsecase {
  final UserRepository repository;

  SignupUsecase({required this.repository});

  Future<Either<Failure, void>> call(SignupRequest request) =>
      repository.signup(request);
}

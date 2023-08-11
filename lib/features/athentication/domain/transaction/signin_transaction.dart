import 'package:todo_test/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/login_request.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

class SigninTransaction {
  final UserRepository repository;

  SigninTransaction({required this.repository});

  Future<Either<Failure, void>> call(LoginRequest param) =>
      repository.login(param);
}

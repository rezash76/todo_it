import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/failure.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/features/athentication/domain/value_object/signup_request.dart';
import 'package:todo_it/features/athentication/domain/repository/user_repository.dart';

base class SignupTransaction implements Transaction<void, SignupRequest> {
  final UserRepository repository;

  SignupTransaction({required this.repository});

  @override
  Future<Either<Failure, void>> call(SignupRequest request) async =>
      await repository.signup(request);
}

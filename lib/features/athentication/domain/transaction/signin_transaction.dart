import 'package:todo_it/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/features/athentication/domain/value_object/signin_request.dart';
import 'package:todo_it/features/athentication/domain/repository/user_repository.dart';

class SigninTransaction implements Transaction<void, SigninRequest> {
  final UserRepository repository;

  SigninTransaction({required this.repository});

  @override
  Future<Either<Failure, void>> call(SigninRequest request) async =>
      await repository.signin(request);
}

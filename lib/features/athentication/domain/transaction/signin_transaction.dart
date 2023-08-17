import 'package:todo_test/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/features/athentication/domain/value_object/signin_request.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

class SigninTransaction implements Transaction<void, SigninRequest> {
  final UserRepository repository;

  SigninTransaction({required this.repository});

  @override
  Future<Either<Failure, void>> call(SigninRequest request) async =>
      await repository.signin(request);
}

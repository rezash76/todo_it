import 'package:todo_test/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

class SignoutTransaction implements Transaction<void, NoRequest> {
  final UserRepository repository;

  SignoutTransaction({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoRequest request) async =>
      await repository.signout();
}

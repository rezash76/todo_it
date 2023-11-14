import 'package:todo_it/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/common/value_object/no_request.dart';
import 'package:todo_it/features/athentication/domain/repository/user_repository.dart';

class SignoutTransaction implements Transaction<void, NoRequest> {
  final UserRepository repository;

  SignoutTransaction({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoRequest request) async =>
      await repository.signout();
}

import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/failure.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/common/value_object/no_request.dart';
import 'package:todo_it/features/athentication/domain/entity/user_entity.dart';
import 'package:todo_it/features/athentication/domain/repository/user_repository.dart';

base class CheckRegistrationTransaction
    implements Transaction<UserEntity, NoRequest> {
  final UserRepository repository;

  CheckRegistrationTransaction(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoRequest request) async =>
      await repository.isUserExist();
}

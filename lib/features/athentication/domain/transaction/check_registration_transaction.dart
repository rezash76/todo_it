import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/athentication/domain/entity/user_entity.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

base class CheckRegistrationTransaction
    implements Transaction<UserEntity, NoRequest> {
  final UserRepository repository;

  CheckRegistrationTransaction(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoRequest request) async =>
      await repository.isUserExist();
}

import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/common/value_object/no_request.dart';

base class GetThemeTransaction implements Transaction<int, NoRequest> {
  final DrawerRepository repository;

  GetThemeTransaction(this.repository);

  @override
  Future<Either<Failure, int>> call(NoRequest request) => repository.getTheme();
}

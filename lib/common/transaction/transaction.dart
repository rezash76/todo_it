import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/failure.dart';

abstract interface class Transaction<T, Req> {
  Future<Either<Failure, T>> call(Req request);
}

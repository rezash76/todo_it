import 'package:todo_test/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';

class LogoutUsecase {
  final UserRepository repository;

  LogoutUsecase({required this.repository});

  Either<Failure, void> call() => repository.signout();
}

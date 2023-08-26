import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/value_object/void_operation.dart';
import 'package:todo_test/features/athentication/domain/transaction/signup_transaction.dart';
import 'package:todo_test/features/athentication/domain/value_object/signup_request.dart';

import 'mock_user_repository.mocks.dart';

void main() {
  late SignupTransaction signupTransaction;
  late MockUserRepository mockUserRepository;
  const request = SignupRequest(
    firstname: 'firstname',
    lastname: 'lastname',
    username: 'username',
    password: 'password',
  );
  // exceptin
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  setUp(() {
    mockUserRepository = MockUserRepository();
    signupTransaction = SignupTransaction(repository: mockUserRepository);
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('Signup transaction', () {
    test('should return void', () async {
      when(mockUserRepository.signup(any))
          .thenAnswer((_) async => Right(VoidOperation().voidValue));

      var result = await signupTransaction.call(request);
      verify(mockUserRepository.signup(request));
      expect(result, Right(VoidOperation().voidValue));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return TypeMissmatch Exception.', () async {
      when(mockUserRepository.signup(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await signupTransaction.call(request);
      verify(mockUserRepository.signup(request));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return HiveException.', () async {
      when(mockUserRepository.signup(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await signupTransaction.call(request);
      verify(mockUserRepository.signup(request));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}

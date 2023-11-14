import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/value_object/void_operation.dart';
import 'package:todo_it/features/athentication/domain/transaction/signin_transaction.dart';
import 'package:todo_it/features/athentication/domain/value_object/signin_request.dart';

import 'mock_user_repository.mocks.dart';

void main() {
  late SigninTransaction signinTransaction;
  late MockUserRepository mockUserRepository;
  late SigninRequest request;
  // exception
  late WrongPassword wrongPassword;
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  setUp(() {
    mockUserRepository = MockUserRepository();
    signinTransaction = SigninTransaction(repository: mockUserRepository);
    request = SigninRequest('username', 'password');
    wrongPassword = WrongPassword();
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('Signin transaction', () {
    test('should return void', () async {
      when(mockUserRepository.signin(any))
          .thenAnswer((_) async => Right(VoidOperation().voidValue));

      var result = await signinTransaction.call(request);
      verify(mockUserRepository.signin(request));
      expect(result, Right(VoidOperation().voidValue));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return WrongPassword Exception when pass is wrong.', () async {
      when(mockUserRepository.signin(any))
          .thenAnswer((_) async => Left(wrongPassword));

      var result = await signinTransaction.call(request);
      verify(mockUserRepository.signin(request));
      expect(result, Left(wrongPassword));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return TypeMissmatch Exception.', () async {
      when(mockUserRepository.signin(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await signinTransaction.call(request);
      verify(mockUserRepository.signin(request));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return HiveException.', () async {
      when(mockUserRepository.signin(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await signinTransaction.call(request);
      verify(mockUserRepository.signin(request));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}

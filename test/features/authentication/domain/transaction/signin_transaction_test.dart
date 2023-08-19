import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/value_object/void_operation.dart';
import 'package:todo_test/features/athentication/domain/transaction/signin_transaction.dart';
import 'package:todo_test/features/athentication/domain/value_object/signin_request.dart';

import 'check_registration_transaction_test.mocks.dart';

void main() {
  late SigninTransaction signinTransaction;
  late MockUserRepository mockUserRepository;
  var request = SigninRequest('username', 'password');

  setUp(() {
    mockUserRepository = MockUserRepository();
    signinTransaction = SigninTransaction(repository: mockUserRepository);
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
  });
}

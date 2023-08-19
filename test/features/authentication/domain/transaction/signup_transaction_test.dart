import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/value_object/void_operation.dart';
import 'package:todo_test/features/athentication/domain/transaction/signup_transaction.dart';
import 'package:todo_test/features/athentication/domain/value_object/signup_request.dart';

import 'check_registration_transaction_test.mocks.dart';

void main() {
  late SignupTransaction signupTransaction;
  late MockUserRepository mockUserRepository;
  const request = SignupRequest(
    firstname: 'firstname',
    lastname: 'lastname',
    username: 'username',
    password: 'password',
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    signupTransaction = SignupTransaction(repository: mockUserRepository);
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
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/common/value_object/void_operation.dart';
import 'package:todo_test/features/athentication/domain/transaction/signout_transaction.dart';

import 'check_registration_transaction_test.mocks.dart';

void main() {
  late SignoutTransaction signoutTransaction;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    signoutTransaction = SignoutTransaction(repository: mockUserRepository);
  });

  group('Signout transaction', () {
    test('should return void', () async {
      when(mockUserRepository.signout())
          .thenAnswer((_) async => Right(VoidOperation().voidValue));

      var result = await signoutTransaction.call(NoRequest());
      verify(mockUserRepository.signout());
      expect(result, Right(VoidOperation().voidValue));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}

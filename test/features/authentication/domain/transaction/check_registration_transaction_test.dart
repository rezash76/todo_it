import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/athentication/domain/entity/user_entity.dart';
import 'package:todo_test/features/athentication/domain/transaction/check_registration_transaction.dart';

import 'check_registration_transaction_test.mocks.dart';

void main() {
  late CheckRegistrationTransaction checkRegistrationTransaction;
  late MockUserRepository mockUserRepository;
  UserEntity user = UserEntity(
    'name',
    'family',
    'username',
    'password',
    true,
  );

  setUp(() {
    mockUserRepository = MockUserRepository();
    checkRegistrationTransaction =
        CheckRegistrationTransaction(mockUserRepository);
  });

  group('Check registraion transaction', () {
    test('should return UserEntity', () async {
      when(mockUserRepository.isUserExist())
          .thenAnswer((_) async => Right(user));

      var result = await checkRegistrationTransaction.call(NoRequest());
      verify(mockUserRepository.isUserExist());
      expect(result, Right(user));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}

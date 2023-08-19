import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/athentication/domain/entity/user_entity.dart';
import 'package:todo_test/features/athentication/domain/transaction/check_registration_transaction.dart';

import 'check_registration_transaction_test.mocks.dart';

void main() {
  late CheckRegistrationTransaction checkRegistrationTransaction;
  late MockUserRepository mockUserRepository;
  late UserEntity user;
  // exception
  late NotFound notFoundException;
  late HiveException hiveException;

  setUp(() {
    mockUserRepository = MockUserRepository();
    checkRegistrationTransaction =
        CheckRegistrationTransaction(mockUserRepository);
    notFoundException = NotFound();
    hiveException = HiveException();
    user = UserEntity(
      'name',
      'family',
      'username',
      'password',
      true,
    );
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

    test('should return NotFoundException when user not exist.', () async {
      when(mockUserRepository.isUserExist())
          .thenAnswer((_) async => Left(notFoundException));

      var result = await checkRegistrationTransaction.call(NoRequest());
      verify(mockUserRepository.isUserExist());
      expect(result, Left(notFoundException));
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('should return HiveException when throws HiveError.', () async {
      when(mockUserRepository.isUserExist())
          .thenAnswer((_) async => Left(hiveException));

      var result = await checkRegistrationTransaction.call(NoRequest());
      verify(mockUserRepository.isUserExist());
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}

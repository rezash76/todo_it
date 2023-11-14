import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_it/common/value_object/no_request.dart';
import 'package:todo_it/features/athentication/domain/entity/user_entity.dart';
import 'package:todo_it/features/athentication/domain/transaction/check_registration_transaction.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckRegistrationTransaction transaction;

  SplashBloc(this.transaction) : super(SplashInitial()) {
    on<UserIsExist>(_userIsExistEventHandler);
  }

  _userIsExistEventHandler(UserIsExist event, Emitter emit) async {
    final result = await transaction(NoRequest());
    result.fold(
      (failure) => emit(SplashErrorUserExist(failure.message)),
      (user) => emit(SplashSeccessUserExist(user)),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/athentication/domain/transaction/check_registration_transaction.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckRegistrationTransaction usecase;

  SplashBloc(this.usecase) : super(SplashInitial()) {
    on<UserIsExist>(_userIsExistEventHandler);
  }

  _userIsExistEventHandler(UserIsExist event, Emitter emit) {
    final result = usecase();
    result.fold(
      (failure) => emit(SplashErrorUserExist(failure.message)),
      (user) => emit(SplashSeccessUserExist(user)),
    );
  }
}

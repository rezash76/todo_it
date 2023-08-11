import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/common/core/domain/entities/user_entity.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/login_request.dart';
import 'package:todo_test/features/athentication/domain/transaction/signin_transaction.dart';
import 'package:todo_test/features/athentication/domain/transaction/signout_transaction.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SigninTransaction loginUsecase;
  final LogoutUsecase logoutUsecase;

  LoginBloc(this.loginUsecase, this.logoutUsecase) : super(LoginInitial()) {
    on<SignInEvent>(_loginEventHandler);
    on<LogoutEvent>(_logoutEventHandler);
  }

  _loginEventHandler(SignInEvent event, Emitter emit) {
    final result = loginUsecase(event.param);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) => emit(LoginSuccess(user: user)),
    );
  }

  _logoutEventHandler(LogoutEvent event, Emitter emit) {
    final result = logoutUsecase();
    result.fold(
      (failure) => emit(LogoutError(failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }
}

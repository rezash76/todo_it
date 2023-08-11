import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/features/athentication/domain/entity/value_object/signin_request.dart';
import 'package:todo_test/features/athentication/domain/transaction/signin_transaction.dart';
import 'package:todo_test/features/athentication/domain/transaction/signout_transaction.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final SigninTransaction loginUsecase;
  final LogoutUsecase logoutUsecase;

  SigninBloc(this.loginUsecase, this.logoutUsecase) : super(SigninInitial()) {
    on<SignInEvent>(_loginEventHandler);
    on<SignoutEvent>(_logoutEventHandler);
  }

  _loginEventHandler(SignInEvent event, Emitter emit) async {
    final result = await loginUsecase(event.request);
    result.fold(
      (failure) => emit(SigninError(failure.message)),
      (user) => emit(SigninSuccess()),
    );
  }

  _logoutEventHandler(SignoutEvent event, Emitter emit) {
    final result = logoutUsecase();
    result.fold(
      (failure) => emit(SignoutError(failure.message)),
      (_) => emit(SignoutSuccess()),
    );
  }
}

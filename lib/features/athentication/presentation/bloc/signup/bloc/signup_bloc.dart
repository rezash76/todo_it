import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_it/features/athentication/domain/value_object/signup_request.dart';

import '../../../../domain/transaction/signup_transaction.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupTransaction usecase;

  SignupBloc(this.usecase) : super(SignupInitial()) {
    on<Signup>(_signupEventHandler);
  }

  _signupEventHandler(Signup event, Emitter emit) async {
    final result = await usecase(event.request);
    result.fold(
      (failure) => emit(SignupError(failure.message)),
      (success) => emit(SignupSuccess()),
    );
  }
}

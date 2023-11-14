import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_it/common/value_object/no_request.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/transaction/category/get_cat_transaction.dart';
import 'package:todo_it/features/todo/domain/transaction/category/set_cat_transaction.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final GetCatTransaction getCatTransaction;
  final SetCatTransaction setCatTransaction;
  CatBloc(this.getCatTransaction, this.setCatTransaction)
      : super(CatInitial()) {
    on<GetCat>(_getCatHandler);
    on<SetCat>(_setCatHandler);
  }

  _getCatHandler(GetCat event, Emitter emit) async {
    var result = await getCatTransaction(NoRequest());
    result.fold(
      (exception) => emit(GetCatError(exception.message)),
      (cat) => emit(GetCatSuccess(cat)),
    );
  }

  _setCatHandler(SetCat event, Emitter emit) async {
    var result = await setCatTransaction(event.cat);
    result.fold(
      (exception) => emit(GetCatError(exception.message)),
      (cat) => emit(GetCatSuccess(cat)),
    );
  }
}

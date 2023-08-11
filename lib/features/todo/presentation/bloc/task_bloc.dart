import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/add_new_task_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/delete_task_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/get_all_tasks_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/update_task_transaction.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksTransaction getAllTasksUsecase;
  final AddNewTaskTransaction addNewTaskUsecase;
  final UpdateTaskTransaction updateTaskUsecase;
  final DeleteTaskTransaction deleteTaskUsecase;

  TaskBloc(
    this.getAllTasksUsecase,
    this.addNewTaskUsecase,
    this.updateTaskUsecase,
    this.deleteTaskUsecase,
  ) : super(TaskInitial()) {
    on<GetAllTasks>(_getAllTasksEventHandler);
    on<AddNewTask>(_addNewTaskEventHandler);
    on<DeleteTask>(_deleteTaskEventHandler);
    on<UpdateTask>(_updateTaskEventHandler);
  }

  _getAllTasksEventHandler(GetAllTasks event, Emitter emit) {
    final tasks = getAllTasksUsecase();
    tasks.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) => emit(TaskSuccess(tasks)),
    );
  }

  _addNewTaskEventHandler(AddNewTask event, Emitter emit) async {
    final tasks = await addNewTaskUsecase(event.task);
    tasks.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) => emit(TaskSuccess(tasks)),
    );
  }

  _updateTaskEventHandler(UpdateTask event, Emitter emit) async {
    final isCompleted = await updateTaskUsecase(event.task, event.index);
    isCompleted.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) => emit(TaskSuccess(tasks)),
    );
  }

  _deleteTaskEventHandler(DeleteTask event, Emitter emit) async {
    final isDeleted = await deleteTaskUsecase(event.index);
    isDeleted.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) => emit(TaskSuccess(tasks)),
    );
  }
}

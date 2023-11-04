import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/add_new_task_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/delete_task_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/get_all_tasks_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/get_cat_tasks_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/update_task_transaction.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksTransaction getAllTasksTransaction;
  final GetCatTasksTransaction getCatTasksTransaction;
  final AddNewTaskTransaction addNewTaskTransaction;
  final UpdateTaskTransaction updateTaskTransaction;
  final DeleteTaskTransaction deleteTaskTransaction;

  TaskBloc(
    this.getAllTasksTransaction,
    this.getCatTasksTransaction,
    this.addNewTaskTransaction,
    this.updateTaskTransaction,
    this.deleteTaskTransaction,
  ) : super(TaskInitial()) {
    on<GetAllTasks>(_getAllTasksEventHandler);
    on<GetCatTasks>(_getCatTasksEventHandler);
    on<AddNewTask>(_addNewTaskEventHandler);
    on<DeleteTask>(_deleteTaskEventHandler);
    on<UpdateTask>(_updateTaskEventHandler);
  }

  _getAllTasksEventHandler(GetAllTasks event, Emitter emit) async {
    final tasks = await getAllTasksTransaction(NoRequest());

    tasks.fold(
      (exception) => emit(TaskError(exception.message)),
      (tasks) {
        _emitTasks(tasks, emit);
      },
    );
  }

  _getCatTasksEventHandler(GetCatTasks event, Emitter emit) async {
    final tasks = await getCatTasksTransaction(event.cat);
    tasks.fold(
      (exception) => emit(TaskError(exception.message)),
      (tasks) {
        _emitTasks(tasks, emit);
      },
    );
  }

  _addNewTaskEventHandler(AddNewTask event, Emitter emit) async {
    final tasks = await addNewTaskTransaction(event.task);
    tasks.fold(
      (exception) => emit(TaskError(exception.message)),
      (tasks) {
        _emitTasks(tasks, emit);
      },
    );
  }

  _updateTaskEventHandler(UpdateTask event, Emitter emit) async {
    final isCompleted = await updateTaskTransaction(event.task);
    isCompleted.fold(
      (exception) => emit(TaskError(exception.message)),
      (tasks) {
        _emitTasks(tasks, emit);
      },
    );
  }

  _deleteTaskEventHandler(DeleteTask event, Emitter emit) async {
    final isDeleted = await deleteTaskTransaction(event.taskId);
    isDeleted.fold(
      (exception) => emit(TaskError(exception.message)),
      (tasks) {
        _emitTasks(tasks, emit);
      },
    );
  }

  void _emitTasks(List<TaskEntity> allTasks, Emitter emit) {
    var unCompletedTasks =
        allTasks.where((task) => task.isCompleted == false).toList();
    var completedTasks =
        allTasks.where((task) => task.isCompleted == true).toList();

    emit(
      TaskSuccess(
        tasks: unCompletedTasks,
        completedTasks: completedTasks,
        category:
            allTasks.isNotEmpty ? allTasks[0].category : TaskCategory.personal,
      ),
    );
  }
}

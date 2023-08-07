part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskSuccess extends TaskState {
  final List<TaskEntity> tasks;

  TaskSuccess(this.tasks);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

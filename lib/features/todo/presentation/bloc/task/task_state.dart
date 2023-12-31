part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskSuccess extends TaskState {
  final List<TaskEntity> tasks;
  final List<TaskEntity>? completedTasks;
  final TaskCategory category;

  TaskSuccess({
    required this.tasks,
    this.completedTasks,
    this.category = TaskCategory.personal,
  });
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

class TaskCat extends TaskState {
  final TaskCategory category;

  TaskCat({
    required this.category,
  });
}

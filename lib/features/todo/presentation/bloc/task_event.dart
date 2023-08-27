part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetAllTasks extends TaskEvent {}

class AddNewTask extends TaskEvent {
  final TaskRequest task;
  AddNewTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskRequest task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;
  DeleteTask(this.taskId);
}

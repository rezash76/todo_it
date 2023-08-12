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
  final int index;
  UpdateTask(this.task, this.index);
}

class DeleteTask extends TaskEvent {
  final int index;
  DeleteTask(this.index);
}

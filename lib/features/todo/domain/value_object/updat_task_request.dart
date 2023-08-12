import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

base class UpdateTaskRequest {
  final TaskRequest taskParam;
  final int index;

  UpdateTaskRequest(
    this.taskParam,
    this.index,
  );
}

import 'package:todo_test/features/todo/domain/entity/task_entity.dart';

base class TaskRequest {
  final String id;
  final String title;
  final String desc;
  TaskCategory category;
  final bool isCompleted;
  final String createTime;

  TaskRequest(
    this.id,
    this.title,
    this.desc,
    this.isCompleted,
    this.createTime, {
    this.category = TaskCategory.personal,
  });
}

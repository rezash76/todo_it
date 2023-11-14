import 'package:todo_it/features/todo/domain/entity/task_entity.dart';

base class TaskRequest {
  final String id;
  final String title;
  final String desc;
  final TaskCategory category;
  final bool isCompleted;
  final String createTime;

  TaskRequest({
    required this.id,
    required this.title,
    required this.desc,
    required this.isCompleted,
    required this.createTime,
    required this.category,
  });
}

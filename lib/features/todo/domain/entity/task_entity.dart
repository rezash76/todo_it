import 'package:todo_it/common/entity/entity.dart';

base class TaskEntity extends Entity {
  final String title;
  final String desc;
  TaskCategory category;
  bool isCompleted;
  String createTime;

  TaskEntity({
    required String id,
    required this.title,
    required this.desc,
    required this.category,
    required this.isCompleted,
    required this.createTime,
  }) : super(id: id);
}

enum TaskCategory {
  personal,
  work,
  learning,
  shopping,
}

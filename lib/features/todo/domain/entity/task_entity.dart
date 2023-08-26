import 'package:todo_test/common/entity/entity.dart';

base class TaskEntity extends Entity {
  final String title;
  final String desc;
  bool isCompleted;

  TaskEntity({
    required String id,
    required this.title,
    required this.desc,
    required this.isCompleted,
  }) : super(id: id);
}

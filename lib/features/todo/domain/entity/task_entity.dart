import 'package:todo_test/common/entity/entity.dart';
import 'package:uuid/uuid.dart';

base class TaskEntity extends Entity {
  final String title;
  final String desc;
  bool isCompleted;

  TaskEntity(
    this.title,
    this.desc,
    this.isCompleted,
  ) : super(const Uuid().v1());
}

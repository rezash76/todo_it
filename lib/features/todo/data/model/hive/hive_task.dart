import 'package:hive/hive.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';

part 'hive_task.g.dart';

@HiveType(typeId: 1)
base class HiveTask extends HiveObject {
  HiveTask(
    this.id,
    this.title,
    this.desc,
    this.category,
    this.isCompleted,
    this.createTime,
  );

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String desc;

  @HiveField(3)
  TaskCategory category;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  String createTime;
}

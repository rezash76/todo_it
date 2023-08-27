import 'package:hive/hive.dart';

part 'hive_task.g.dart';

@HiveType(typeId: 1)
base class HiveTask extends HiveObject {
  HiveTask(
    this.id,
    this.title,
    this.desc,
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
  bool isCompleted;

  @HiveField(4)
  String createTime;
}

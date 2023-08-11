import 'package:hive/hive.dart';

part 'hive_task.g.dart';

@HiveType(typeId: 1)
base class HiveTask extends HiveObject {
  HiveTask(this.title, this.desc, this.isCompleted);

  @HiveField(0)
  String title;

  @HiveField(1)
  String desc;

  @HiveField(2)
  bool isCompleted;
}

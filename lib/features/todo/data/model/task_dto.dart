import 'package:todo_test/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';

base class TaskDTO extends TaskEntity {
  TaskDTO({
    required super.id,
    required super.title,
    required super.desc,
    required super.category,
    required super.isCompleted,
    required super.createTime,
  });

  factory TaskDTO.fromDB(HiveTask hiveTask) {
    var category = TaskCategory.personal;
    switch (hiveTask.category) {
      case 'personal':
        category = TaskCategory.personal;
      case 'work':
        category = TaskCategory.work;
      case 'learning':
        category = TaskCategory.learning;
    }

    return TaskDTO(
      id: hiveTask.id,
      title: hiveTask.title,
      desc: hiveTask.desc,
      category: category,
      isCompleted: hiveTask.isCompleted,
      createTime: hiveTask.createTime,
    );
  }
}

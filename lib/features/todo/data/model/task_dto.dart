import 'package:todo_test/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';

base class TaskDTO extends TaskEntity {
  TaskDTO(
    super.title,
    super.desc,
    super.isCompleted,
  );

  factory TaskDTO.fromDB(HiveTask hiveTask) {
    return TaskDTO(
      hiveTask.title,
      hiveTask.desc,
      hiveTask.isCompleted,
    );
  }
}

import 'package:todo_test/common/core/data/hive_model/hive_task.dart';
import 'package:todo_test/common/core/domain/entities/task_entity.dart';

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

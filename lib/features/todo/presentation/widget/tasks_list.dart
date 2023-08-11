import 'package:flutter/material.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/presentation/widget/show_add_task_buttomsheet.dart';
import 'package:todo_test/features/todo/presentation/widget/task_dismissible_list_view.dart';

class TaskList extends StatelessWidget {
  final List<TaskEntity> tasks;
  final TextEditingController titleController;
  final TextEditingController descController;

  const TaskList({
    super.key,
    required this.tasks,
    required this.titleController,
    required this.descController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final int keyIndex = (tasks.length - index) - 1;
        return GestureDetector(
          onTap: () {
            titleController.text = tasks[index].title;
            descController.text = tasks[index].desc;
            showAddTaskBottomSheet(
              context,
              titleController,
              descController,
              true,
              keyIndex,
            );
          },
          child: TaskDismissibleListView(
            tasks: tasks,
            index: index,
            keyIndex: keyIndex,
          ),
        );
      },
    );
  }
}

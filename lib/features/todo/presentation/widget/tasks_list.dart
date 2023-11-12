import 'package:flutter/material.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/presentation/screen/task_screen.dart';
import 'package:todo_test/features/todo/presentation/widget/task_dismissible.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListView.separated(
        separatorBuilder: ((context, index) => const Divider(
              height: 1,
              color: Colors.grey,
            )),
        // padding: const EdgeInsets.symmetric(vertical: 12),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              titleController.text = tasks[index].title;
              descController.text = tasks[index].desc;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskScreen(
                    titleController: titleController,
                    descController: descController,
                    task: tasks[index],
                    isUpdate: true,
                  ),
                ),
              );
            },
            child: TaskDismissible(
              task: tasks[index],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/value_object/task_request.dart';
import 'package:todo_it/features/todo/presentation/bloc/task/task_bloc.dart';

class TaskCard extends StatefulWidget {
  final TaskEntity task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isComplete = false;

  @override
  void initState() {
    super.initState();
    isComplete = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 60,
              color: getCategoryColor(),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: themeData.textTheme.titleLarge,
                  ),
                  if (widget.task.desc.isNotEmpty)
                    Text(
                      widget.task.desc.toString().trim(),
                      style: themeData.textTheme.titleMedium,
                    ),
                ],
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  value: widget.task.isCompleted,
                  onChanged: (value) {
                    if (value != null) {
                      var taskRequest = TaskRequest(
                        id: widget.task.id,
                        title: widget.task.title,
                        desc: widget.task.desc,
                        isCompleted: value,
                        category: widget.task.category,
                        createTime: widget.task.createTime,
                      );
                      BlocProvider.of<TaskBloc>(context)
                          .add(UpdateTask(taskRequest));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color? getCategoryColor() {
    switch (widget.task.category) {
      case TaskCategory.personal:
        return Colors.red;
      case TaskCategory.work:
        return Colors.blue;
      case TaskCategory.learning:
        return Colors.purple;
      case TaskCategory.shopping:
        return Colors.green;
      default:
        Colors.red;
    }
    return null;
  }
}

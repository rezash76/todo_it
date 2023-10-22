import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';

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
      // margin: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/book.svg',
              width: 40,
              height: 40,
              // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.src),
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
                    style: themeData.textTheme.titleLarge!
                        .copyWith(color: Colors.black87),
                  ),
                  Text(
                    widget.task.desc.toString().trim(),
                    style: themeData.textTheme.titleMedium!
                        .copyWith(color: Colors.black87),
                  ),
                ],
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return Checkbox(
                  checkColor: Colors.amberAccent,
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
            Container(
              width: 5,
              height: 60,
              color: getCategoryColor(),
            ),
          ],
        ),
      ),
    );
  }

  Color? getCategoryColor() {
    switch (widget.task.category) {
      case TaskCategory.personal:
        return Colors.pinkAccent;
      case TaskCategory.work:
        return Colors.greenAccent;
      case TaskCategory.learning:
        return Colors.yellowAccent;
      default:
        Colors.pinkAccent;
    }
    return null;
  }
}

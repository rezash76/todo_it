import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/core/domain/entities/task_entity.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';

class TaskCard extends StatefulWidget {
  final TaskEntity task;
  final int keyIndex;

  const TaskCard({
    super.key,
    required this.task,
    required this.keyIndex,
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
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(250, 210, 85, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Divider(
                      color: Colors.black26,
                      height: 1,
                    ),
                  ),
                  Text(
                    widget.task.desc.toString().trim(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
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
                      var newTask = TaskParam(
                        widget.task.title,
                        widget.task.desc,
                        value,
                      );
                      BlocProvider.of<TaskBloc>(context).add(UpdateTask(
                        newTask,
                        widget.keyIndex,
                      ));
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
}

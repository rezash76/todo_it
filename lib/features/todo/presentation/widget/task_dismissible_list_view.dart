import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/core/domain/entities/task_entity.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todo_test/features/todo/presentation/widget/task_card.dart';

class TaskDismissibleListView extends StatelessWidget {
  const TaskDismissibleListView({
    super.key,
    required this.tasks,
    required this.index,
    required this.keyIndex,
  });

  final List<TaskEntity> tasks;
  final int index;
  final int keyIndex;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: dismissBackgroundContainer(isDelete: false),
      secondaryBackground: dismissBackgroundContainer(isDelete: true),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          var newTask = TaskParam(
            tasks[index].title,
            tasks[index].desc,
            true,
          );
          BlocProvider.of<TaskBloc>(context).add(UpdateTask(
            newTask,
            keyIndex,
          ));
          return false;
        } else {
          return true;
        }
      },
      onDismissed: (_) {
        // delete the task from Hive
        BlocProvider.of<TaskBloc>(context).add(DeleteTask(keyIndex));
      },
      child: TaskCard(
        task: tasks[index],
        keyIndex: keyIndex,
      ),
    );
  }

  Container dismissBackgroundContainer({required bool isDelete}) {
    return Container(
      color: isDelete ? Colors.red : const Color.fromRGBO(76, 175, 80, 1),
      child: Align(
        alignment: isDelete ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: isDelete
              ? const EdgeInsets.only(right: 32)
              : const EdgeInsets.only(left: 32),
          child: Icon(
            isDelete ? Icons.delete : Icons.done,
            size: 32,
          ),
        ),
      ),
    );
  }
}

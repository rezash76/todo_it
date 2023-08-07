import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/core/presentation/widget/custom_text_form_field.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';

showAddTaskBottomSheet(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descController,
  bool isUpdate,
  int? keyIndex,
) {
  showDialog(
    context: context,
    builder: (BuildContext cxt) {
      return AlertDialog(
        title: Text(
          titleController.text == '' ? 'Add new Task' : 'Update the Task',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: ListBody(
              children: [
                CustomTextFormField(
                  controller: titleController,
                  labelText: 'Title',
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  controller: descController,
                  labelText: 'Description',
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              titleController.text == '' ? 'Add' : 'Update',
            ),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descController.text.isNotEmpty) {
                var task = TaskParam(
                  titleController.text,
                  descController.text,
                  false,
                );
                if (isUpdate && keyIndex != null) {
                  BlocProvider.of<TaskBloc>(context).add(
                    UpdateTask(
                      task,
                      keyIndex,
                    ),
                  );
                } else {
                  BlocProvider.of<TaskBloc>(context).add(
                    AddNewTask(task),
                  );
                }
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/component/custom_text_form_field.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';

showAddTaskBottomSheet(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descController,
  bool isUpdate,
  int? keyIndex,
) {
  ThemeData themeData = Theme.of(context);
  showDialog(
    context: context,
    builder: (BuildContext cxt) {
      return AlertDialog(
        title: Text(
          titleController.text == ''
              ? LanguageManager.shared.translation(context).addNewTask
              : LanguageManager.shared.translation(context).updateTheTask,
          style: themeData.textTheme.titleLarge,
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ListBody(
              children: [
                CustomTextFormField(
                  controller: titleController,
                  labelText: LanguageManager.shared.translation(context).title,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: descController,
                  labelText:
                      LanguageManager.shared.translation(context).description,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              titleController.text == ''
                  ? LanguageManager.shared.translation(context).add
                  : LanguageManager.shared.translation(context).update,
              style: themeData.textTheme.titleMedium,
            ),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descController.text.isNotEmpty) {
                var task = TaskRequest(
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

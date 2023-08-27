import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/component/custom_text_form_field.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';
import 'package:uuid/uuid.dart';

showAddTaskBottomSheet({
  required BuildContext context,
  TaskEntity? task,
  required TextEditingController titleController,
  required TextEditingController descController,
  required bool isUpdate,
}) {
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
                final timeStamp =
                    DateTime.now().millisecondsSinceEpoch.toString();
                var taskRequest = TaskRequest(
                  isUpdate
                      ? (task != null ? task.id : const Uuid().v4())
                      : const Uuid().v4(),
                  titleController.text,
                  descController.text,
                  false,
                  isUpdate
                      ? (task != null ? task.createTime : timeStamp)
                      : timeStamp,
                );
                BlocProvider.of<TaskBloc>(context).add(
                  isUpdate ? UpdateTask(taskRequest) : AddNewTask(taskRequest),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

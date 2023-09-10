import 'package:flutter/cupertino.dart';
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
  TaskCategory selectedValue = TaskCategory.personal,
}) {
  ThemeData themeData = Theme.of(context);
  Size size = MediaQuery.sizeOf(context);
  Map<String, Container> segmentChildren = {
    'personal': Container(
      width: size.width * 0.33,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        LanguageManager.shared.translation(context).personal,
        textAlign: TextAlign.center,
        style: themeData.textTheme.titleMedium!.copyWith(
          color: const Color.fromARGB(229, 255, 255, 255),
        ),
      ),
    ),
    'work': Container(
      width: size.width * 0.33,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        LanguageManager.shared.translation(context).work,
        textAlign: TextAlign.center,
        style: themeData.textTheme.titleMedium!.copyWith(
          color: const Color.fromARGB(229, 255, 255, 255),
        ),
      ),
    ),
    'learning': Container(
      width: size.width * 0.33,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        LanguageManager.shared.translation(context).learning,
        textAlign: TextAlign.center,
        style: themeData.textTheme.titleMedium!.copyWith(
          color: const Color.fromARGB(229, 255, 255, 255),
        ),
      ),
    ),
  };
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
        content: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ListBody(
                  children: [
                    CustomTextFormField(
                      controller: titleController,
                      labelText:
                          LanguageManager.shared.translation(context).title,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: descController,
                      labelText: LanguageManager.shared
                          .translation(context)
                          .description,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    CupertinoSegmentedControl(
                      groupValue: selectedValue.name,
                      children: segmentChildren,
                      onValueChanged: (value) async {
                        setState(() {
                          if (value == 'personal') {
                            selectedValue = TaskCategory.personal;
                          }
                          if (value == 'work') {
                            selectedValue = TaskCategory.work;
                          }
                          if (value == 'learning') {
                            selectedValue = TaskCategory.learning;
                          }
                        });
                      },
                      selectedColor: const Color.fromARGB(255, 147, 10, 65),
                      unselectedColor: const Color.fromARGB(255, 36, 37, 56),
                      borderColor: CupertinoColors.inactiveGray,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
                  category: selectedValue,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/component/custom_text_form_field.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo_test/features/todo/presentation/widget/category_row.dart';
import 'package:uuid/uuid.dart';

class TaskScreen extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final bool isUpdate;
  TaskEntity? task;
  TaskScreen({
    super.key,
    required this.titleController,
    required this.descController,
    required this.isUpdate,
    this.task,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TaskCategory category = TaskCategory.personal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.titleController.text == ''
              ? LanguageManager.shared.translation(context).addNewTask
              : LanguageManager.shared.translation(context).updateTheTask,
          style: themeData.textTheme.titleLarge!.copyWith(
            color: const Color.fromARGB(255, 14, 3, 54),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageManager.shared.translation(context).title,
                  style: themeData.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: widget.titleController,
                  hintText: LanguageManager.shared.translation(context).title,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  LanguageManager.shared.translation(context).description,
                  style: themeData.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  controller: widget.descController,
                  hintText:
                      LanguageManager.shared.translation(context).description,
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  LanguageManager.shared.translation(context).categories,
                  style: themeData.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Hero(
                  tag: 'cat',
                  child: CategoryRow(
                    callback: (cat) => category = cat,
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.titleController.text.isNotEmpty &&
                          widget.descController.text.isNotEmpty) {
                        final timeStamp =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        var taskRequest = TaskRequest(
                          id: widget.isUpdate
                              ? (widget.task != null
                                  ? widget.task!.id
                                  : const Uuid().v4())
                              : const Uuid().v4(),
                          title: widget.titleController.text,
                          desc: widget.descController.text,
                          isCompleted: false,
                          createTime: widget.isUpdate
                              ? (widget.task != null
                                  ? widget.task!.createTime
                                  : timeStamp)
                              : timeStamp,
                          category: category,
                        );
                        BlocProvider.of<TaskBloc>(context).add(
                          widget.isUpdate
                              ? UpdateTask(taskRequest)
                              : AddNewTask(taskRequest),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(200, 5, 189, 121),
                    ),
                    child: Text(
                      widget.titleController.text == ''
                          ? LanguageManager.shared.translation(context).add
                          : LanguageManager.shared.translation(context).update,
                      style: themeData.textTheme.titleMedium!.copyWith(
                        color: const Color.fromARGB(255, 14, 3, 54),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

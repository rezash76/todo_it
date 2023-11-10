import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/custom_drawer.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/athentication/presentation/bloc/signin/bloc/signin_bloc.dart';
import 'package:todo_test/features/todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo_test/features/todo/presentation/screen/task_screen.dart';
import 'package:todo_test/features/todo/presentation/widget/category_row.dart';
import 'package:todo_test/features/todo/presentation/widget/empty_task.dart';
import 'package:todo_test/features/todo/presentation/widget/tasks_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
    BlocProvider.of<TaskBloc>(context).add(GetAllTasks());
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        // if (state is SignoutSuccess) {
        //   Navigator.pop(context);
        //   Navigator.pushNamedAndRemoveUntil(
        //     context,
        //     SplashScreen.routName,
        //     (route) => false,
        //   );
        // }
        // if (state is SignoutError) {}
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LanguageManager.shared.translation(context).todoList,
            style: themeData.textTheme.titleLarge!.copyWith(
              color: const Color.fromARGB(255, 14, 3, 54),
            ),
          ),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    callback: (cat) {},
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          if (state.tasks.isNotEmpty)
                            Text(
                              LanguageManager.shared.translation(context).tasks,
                              style: themeData.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          if (state.tasks.isNotEmpty)
                            const SizedBox(
                              height: 4,
                            ),
                          if (state.tasks.isNotEmpty)
                            TaskList(
                              tasks: state.tasks,
                              titleController: titleController,
                              descController: descController,
                            ),
                          if (state.completedTasks != null &&
                              state.completedTasks!.isNotEmpty)
                            const SizedBox(
                              height: 16,
                            ),
                          if (state.completedTasks != null &&
                              state.completedTasks!.isNotEmpty)
                            Text(
                              LanguageManager.shared
                                  .translation(context)
                                  .completed,
                              style: themeData.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          const SizedBox(
                            height: 4,
                          ),
                          TaskList(
                            tasks: state.completedTasks!,
                            titleController: titleController,
                            descController: descController,
                          ),
                        ],
                      );
                    }
                    return EmptyTask(
                      message: LanguageManager.shared
                          .translation(context)
                          .thereIsNoTask,
                    );
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            titleController.text = '';
            descController.text = '';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskScreen(
                  titleController: titleController,
                  descController: descController,
                  isUpdate: false,
                ),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 5, 189, 122),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

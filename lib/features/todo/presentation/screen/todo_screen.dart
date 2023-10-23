import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_test/common/feature/drawer/presentation/custom_drawer.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/athentication/presentation/bloc/signin/bloc/signin_bloc.dart';
import 'package:todo_test/features/athentication/presentation/screen/splash_screen.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todo_test/features/todo/presentation/widget/empty_task.dart';
import 'package:todo_test/features/todo/presentation/widget/show_add_task_buttomsheet.dart';
import 'package:todo_test/features/todo/presentation/widget/task_cat_icon.dart';
import 'package:todo_test/features/todo/presentation/widget/tasks_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  bool _isVisible = true;

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
        if (state is SignoutSuccess) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            SplashScreen.routName,
            (route) => false,
          );
        }
        if (state is SignoutError) {}
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
          // backgroundColor: const Color.fromRGBO(251, 233, 0, 1),
        ),
        // backgroundColor: const Color.fromARGB(255, 3, 22, 53),
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
                    color: const Color.fromARGB(255, 82, 83, 85),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TaskCatIcon(
                      category: TaskCategory.personal,
                      onTap: () {},
                    ),
                    TaskCatIcon(
                      category: TaskCategory.work,
                      onTap: () {},
                    ),
                    TaskCatIcon(
                      category: TaskCategory.shopping,
                      onTap: () {},
                    ),
                    TaskCatIcon(
                      category: TaskCategory.learning,
                      onTap: () {},
                    ),
                  ],
                ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskSuccess) {
                      return NotificationListener<UserScrollNotification>(
                        onNotification: (notif) {
                          final ScrollDirection direction = notif.direction;
                          setState(
                            () {
                              if (direction == ScrollDirection.reverse) {
                                _isVisible = false;
                              } else if (direction == ScrollDirection.forward) {
                                _isVisible = true;
                              }
                            },
                          );
                          return true;
                        },
                        child: TaskList(
                          tasks: state.tasks,
                          titleController: titleController,
                          descController: descController,
                        ),
                      );
                    }
                    return EmptyTask(
                      message: LanguageManager.shared
                          .translation(context)
                          .thereIsNoTask,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AnimatedSlide(
          duration: const Duration(milliseconds: 400),
          offset: _isVisible ? Offset.zero : const Offset(0, 2),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: _isVisible ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () {
                titleController.text = '';
                descController.text = '';
                showAddTaskBottomSheet(
                  context: context,
                  titleController: titleController,
                  descController: descController,
                  isUpdate: false,
                );
              },
              backgroundColor: const Color.fromRGBO(251, 233, 0, 1),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}

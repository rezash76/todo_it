import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/custom_drawer.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/login_signup/presentation/bloc/login/bloc/login_bloc.dart';
import 'package:todo_test/features/login_signup/presentation/screens/splash_screen.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todo_test/features/todo/presentation/widgets/empty_task.dart';
import 'package:todo_test/features/todo/presentation/widgets/show_add_task_buttomsheet.dart';
import 'package:todo_test/features/todo/presentation/widgets/tasks_list.dart';

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            SplashScreen.routName,
            (route) => false,
          );
        }
        if (state is LogoutError) {}
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LanguageManager.shared.translation(context).todoList),
          centerTitle: true,
          // backgroundColor: const Color.fromRGBO(251, 233, 0, 1),
        ),
        // backgroundColor: const Color.fromARGB(255, 3, 22, 53),
        drawer: const CustomDrawer(),
        body: Center(
          child: Column(
            children: [
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskError) {
                    return EmptyTask(
                      message: LanguageManager.shared
                          .translation(context)
                          .thereIsNoTask,
                    );
                  }
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
                      child: Expanded(
                        child: TaskList(
                          tasks: state.tasks,
                          titleController: titleController,
                          descController: descController,
                        ),
                      ),
                    );
                  }
                  return const Text('Empty');
                },
              ),
            ],
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
                  context,
                  titleController,
                  descController,
                  false,
                  null,
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

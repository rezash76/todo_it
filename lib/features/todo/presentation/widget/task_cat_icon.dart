import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';

class TaskCatIcon extends StatelessWidget {
  final TaskCategory category;
  const TaskCatIcon({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () => BlocProvider.of<TaskBloc>(context).add(
        GetCatTasks(
          cat: category,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                'assets/images/${category.name}.svg',
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            getCatTitle(context),
            style: themeData.textTheme.titleMedium!.copyWith(
              color: const Color.fromARGB(255, 118, 120, 126),
            ),
          ),
        ],
      ),
    );
  }

  String getCatTitle(BuildContext context) {
    switch (category) {
      case TaskCategory.personal:
        return LanguageManager.shared.translation(context).personal;

      case TaskCategory.shopping:
        return LanguageManager.shared.translation(context).shopping;

      case TaskCategory.work:
        return LanguageManager.shared.translation(context).work;

      case TaskCategory.learning:
        return LanguageManager.shared.translation(context).learning;

      default:
        return LanguageManager.shared.translation(context).personal;
    }
  }
}

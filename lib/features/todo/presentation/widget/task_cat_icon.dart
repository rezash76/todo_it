import 'package:flutter/material.dart';
import 'package:todo_it/common/language_manager.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';

class TaskCatIcon extends StatelessWidget {
  final TaskCategory category;
  final bool isSelected;
  final Function() onTap;
  const TaskCatIcon({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: themeData.colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: getCategoryColor(),
                        offset: const Offset(0, 0),
                        blurRadius: 6,
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Image.asset(
                'assets/images/${category.name}.png',
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            getCatTitle(context),
            style: themeData.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  String getCatTitle(BuildContext context) {
    return switch (category) {
      TaskCategory.personal =>
        LanguageManager.shared.translation(context).personal,
      TaskCategory.shopping =>
        LanguageManager.shared.translation(context).shopping,
      TaskCategory.work => LanguageManager.shared.translation(context).work,
      TaskCategory.learning =>
        LanguageManager.shared.translation(context).learning,
    };
  }

  Color getCategoryColor() {
    return switch (category) {
      TaskCategory.personal => Colors.red,
      TaskCategory.work => Colors.blue,
      TaskCategory.learning => Colors.purple,
      TaskCategory.shopping => Colors.green,
    };
  }
}

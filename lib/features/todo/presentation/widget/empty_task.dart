import 'package:flutter/material.dart';
import 'package:todo_it/common/language_manager.dart';

class EmptyTask extends StatelessWidget {
  final String message;
  const EmptyTask({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        Image.asset(
          'assets/images/empty.png',
        ),
        Text(
          message,
          style: themeData.textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          LanguageManager.shared.translation(context).tapPlusToAddNewOne,
          style: themeData.textTheme.titleMedium,
        ),
      ],
    );
  }
}

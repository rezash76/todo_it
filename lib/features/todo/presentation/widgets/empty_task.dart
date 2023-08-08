import 'package:flutter/material.dart';
import 'package:todo_test/common/language_manager.dart';

class EmptyTask extends StatelessWidget {
  final String message;
  const EmptyTask({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/empty.png',
        ),
        Text(
          message,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          LanguageManager.shared.translation(context).tapPlusToAddNewOne,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_test/common/language_manager.dart';

class CustomThemeMode extends StatelessWidget {
  final ThemeMode themeMode;
  final bool isSelected;

  const CustomThemeMode(
      {super.key, required this.themeMode, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return buildThemeMode(context);
  }

  Widget buildThemeMode(BuildContext context) {
    return switch (themeMode) {
      ThemeMode.light => Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: 70,
              height: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 191, 51),
                borderRadius: BorderRadius.circular(12),
                border:
                    isSelected ? Border.all(width: 2, color: Colors.red) : null,
              ),
            ),
            Text(
              LanguageManager.shared.translation(context).light,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
      ThemeMode.dark => Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: 70,
              height: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 13, 19, 58),
                borderRadius: BorderRadius.circular(12),
                border:
                    isSelected ? Border.all(width: 2, color: Colors.red) : null,
              ),
            ),
            Text(
              LanguageManager.shared.translation(context).dark,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
      ThemeMode.system => Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: 70,
              height: 130,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 246, 191, 51),
                    Color.fromARGB(255, 13, 19, 58),
                  ],
                  begin: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(12),
                border:
                    isSelected ? Border.all(width: 2, color: Colors.red) : null,
              ),
            ),
            Text(
              LanguageManager.shared.translation(context).system,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
    };
  }
}

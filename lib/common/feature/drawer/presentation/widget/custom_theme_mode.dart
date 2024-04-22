import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_it/common/language_manager.dart';

class CustomThemeMode extends StatelessWidget {
  final ThemeMode themeMode;
  final bool isSelected;

  const CustomThemeMode({
    super.key,
    required this.themeMode,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return buildThemeMode(context);
  }

  Widget buildThemeMode(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return switch (themeMode) {
      ThemeMode.light => Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(12),
                //   child: SizedBox(
                //     width: 80,
                //     height: 108,
                //     child: Image.asset(
                //       'assets/images/light.jpg',
                //     ),
                //   ),

                //   // SvgPicture.asset(
                //   //   'assets/images/light.svg',
                //   //   width: 70,
                //   //   height: 130,
                //   // ),
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SvgPicture.asset(
                    'assets/images/light.svg',
                    width: 70,
                    height: 130,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 80,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(width: 2, color: Colors.red)
                        : null,
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.all(8),
                //   width: 80,
                //   height: 130,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     border: isSelected
                //         ? Border.all(width: 2, color: Colors.red)
                //         : null,
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: Image.asset(
                //       'assets/images/light.jpg',
                //     ),
                //   ),
                // ),
              ],
            ),
            Text(
              LanguageManager.shared.translation(context).light,
              style: themeData.textTheme.titleSmall!.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
      ThemeMode.dark => Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SvgPicture.asset(
                    'assets/images/dark.svg',
                    width: 70,
                    height: 130,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 80,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(width: 2, color: Colors.red)
                        : null,
                  ),
                ),
              ],
            ),
            Text(
              LanguageManager.shared.translation(context).dark,
              style: themeData.textTheme.titleSmall!.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
      ThemeMode.system => Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: 80,
              height: 130,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 5, 189, 122),
                    Color.fromARGB(255, 29, 29, 32),
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
              style: themeData.textTheme.titleSmall!.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
    };
  }
}

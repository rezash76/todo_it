import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/widget/custom_theme_mode.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/athentication/presentation/bloc/signin/bloc/signin_bloc.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todo_test/main.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String selectedValue = LanguageManager.shared.ENGLISH;

  @override
  void initState() {
    super.initState();
    LanguageManager.shared.getLocale().then((locale) {
      if (locale.languageCode == LanguageManager.shared.ENGLISH) {
        setState(() {
          selectedValue = LanguageManager.shared.ENGLISH;
        });
      } else {
        setState(() {
          selectedValue = LanguageManager.shared.FARSI;
        });
      }
    });
    BlocProvider.of<DrawerBloc>(context).add(GetTheme());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Map<String, Container> segmentChildren = {
      LanguageManager.shared.ENGLISH: buildSegmentContainer(
        context,
        themeData,
        LanguageManager.shared.translation(context).english,
      ),
      LanguageManager.shared.FARSI: buildSegmentContainer(
        context,
        themeData,
        LanguageManager.shared.translation(context).farsi,
      ),
    };
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(
          6,
        ),
        children: [
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<DrawerBloc, DrawerState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Text(
                      LanguageManager.shared.translation(context).appearance,
                      style: themeData.textTheme.titleMedium!.copyWith(
                        fontSize: 20,
                        color: const Color.fromARGB(229, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<DrawerBloc>(context)
                              .add(SetTheme(ThemeMode.light));
                        },
                        child: CustomThemeMode(
                          themeMode: ThemeMode.light,
                          isSelected: ((state is GetThemeSuccess) &&
                                  state.themeMode == ThemeMode.light)
                              ? true
                              : false,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<DrawerBloc>(context)
                              .add(SetTheme(ThemeMode.dark));
                        },
                        child: CustomThemeMode(
                          themeMode: ThemeMode.dark,
                          isSelected: ((state is GetThemeSuccess) &&
                                  state.themeMode == ThemeMode.dark)
                              ? true
                              : false,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<DrawerBloc>(context)
                              .add(SetTheme(ThemeMode.system));
                        },
                        child: CustomThemeMode(
                          themeMode: ThemeMode.system,
                          isSelected: ((state is GetThemeSuccess) &&
                                  state.themeMode == ThemeMode.system)
                              ? true
                              : false,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 30,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.pinkAccent,
            ),
            title: Text(
              LanguageManager.shared.translation(context).personal,
              style: themeData.textTheme.titleMedium!.copyWith(
                color: const Color.fromARGB(255, 139, 211, 79),
              ),
            ),
            onTap: () {
              BlocProvider.of<TaskBloc>(context).add(
                GetCatTasks(
                  cat: TaskCategory.personal,
                ),
              );
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 30,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.work,
              color: Colors.greenAccent,
            ),
            title: Text(
              LanguageManager.shared.translation(context).work,
              style: themeData.textTheme.titleMedium!.copyWith(
                color: const Color.fromARGB(255, 139, 211, 79),
              ),
            ),
            onTap: () {
              BlocProvider.of<TaskBloc>(context).add(
                GetCatTasks(
                  cat: TaskCategory.work,
                ),
              );
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 30,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.book,
              color: Colors.yellowAccent,
            ),
            title: Text(
              LanguageManager.shared.translation(context).learning,
              style: themeData.textTheme.titleMedium!.copyWith(
                color: const Color.fromARGB(255, 139, 211, 79),
              ),
            ),
            onTap: () {
              BlocProvider.of<TaskBloc>(context).add(
                GetCatTasks(
                  cat: TaskCategory.learning,
                ),
              );
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 30,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Text(
                  LanguageManager.shared.translation(context).language,
                  style: themeData.textTheme.titleMedium!.copyWith(
                    fontSize: 20,
                    color: const Color.fromARGB(229, 255, 255, 255),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSegmentedControl(
                    groupValue: selectedValue,
                    children: segmentChildren,
                    onValueChanged: (value) async {
                      setState(() {
                        selectedValue = value;
                      });
                      if (value == LanguageManager.shared.ENGLISH) {
                        Locale locale = await LanguageManager.shared
                            .setLocale(LanguageManager.shared.ENGLISH);
                        // ignore: use_build_context_synchronously
                        MyApp.setLocale(context, locale);
                      } else {
                        Locale locale = await LanguageManager.shared
                            .setLocale(LanguageManager.shared.FARSI);
                        // ignore: use_build_context_synchronously
                        MyApp.setLocale(context, locale);
                      }
                    },
                    selectedColor: const Color.fromARGB(255, 147, 10, 65),
                    unselectedColor: const Color.fromARGB(255, 36, 37, 56),
                    borderColor: CupertinoColors.inactiveGray,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 30,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.redAccent,
            ),
            title: Text(
              LanguageManager.shared.translation(context).logout,
              style: themeData.textTheme.titleMedium!.copyWith(
                color: Colors.red,
              ),
            ),
            onTap: () {
              BlocProvider.of<SigninBloc>(context).add(SignoutEvent());
            },
          ),
        ],
      ),
    );
  }

  Container buildSegmentContainer(
    BuildContext context,
    ThemeData themeData,
    String language,
  ) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.33,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        language,
        textAlign: TextAlign.center,
        style: themeData.textTheme.titleMedium!.copyWith(
          color: const Color.fromARGB(229, 255, 255, 255),
        ),
      ),
    );
  }
}

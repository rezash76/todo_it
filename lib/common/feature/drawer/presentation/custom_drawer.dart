import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/widget/custom_theme_mode.dart';
import 'package:todo_test/common/feature/drawer/presentation/widget/my_drawer_header.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/login_signup/presentation/bloc/login/bloc/login_bloc.dart';
import 'package:todo_test/main.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isEN = true;
  Set<int> selection = <int>{0, 1};

  @override
  void initState() {
    super.initState();
    LanguageManager.shared.getLocale().then((locale) {
      if (locale.languageCode == LanguageManager.shared.ENGLISH) {
        setState(() {
          isEN = true;
        });
      } else {
        setState(() {
          isEN = false;
        });
      }
    });
    BlocProvider.of<DrawerBloc>(context).add(GetUserDataEvent());
    BlocProvider.of<DrawerBloc>(context).add(GetTheme());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(
          6,
        ),
        children: [
          const SizedBox(
            height: 120,
            child: MyDrawerHeadet(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              height: 30,
            ),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    LanguageManager.shared.translation(context).farsi,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: isEN,
                    onChanged: (val) async {
                      setState(() {
                        isEN = val;
                      });
                      if (val) {
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
                  ),
                  Text(
                    LanguageManager.shared.translation(context).english,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
            },
          ),
        ],
      ),
    );
  }
}

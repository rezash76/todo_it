import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/drawer/widget/custom_theme_mode.dart';
import 'package:todo_test/common/feature/drawer/presentation/drawer/widget/my_drawer_header.dart';
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
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 14,
                      bottom: 8,
                    ),
                    child: Text(
                      'Appearance',
                      style: TextStyle(
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
              const Padding(
                padding: EdgeInsets.only(
                  left: 14,
                  bottom: 8,
                ),
                child: Text(
                  'Language',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Farsi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: isEN,
                    onChanged: (val) {
                      setState(() {
                        isEN = val;
                      });
                      if (val) {
                        MyApp.setLocale(context, const Locale('en', ''));
                      } else {
                        MyApp.setLocale(context, const Locale('fa', ''));
                      }
                    },
                  ),
                  const Text(
                    'English',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
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

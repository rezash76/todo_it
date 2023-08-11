import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/common/theme/theme_config.dart';
import 'package:todo_test/features/athentication/presentation/bloc/signin/bloc/signin_bloc.dart';
import 'package:todo_test/features/athentication/presentation/bloc/signup/bloc/signup_bloc.dart';
import 'package:todo_test/features/athentication/presentation/screen/splash_screen.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';
import 'package:todo_test/service_locator.dart' as locator;
import 'package:todo_test/service_locator.dart';
import 'features/athentication/presentation/bloc/splash/bloc/splash_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await locator.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SplashBloc>()),
        BlocProvider(create: (context) => sl<SignupBloc>()),
        BlocProvider(create: (context) => sl<SigninBloc>()),
        BlocProvider(create: (context) => sl<TaskBloc>()),
        BlocProvider(create: (context) => sl<DrawerBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(LanguageManager.shared.ENGLISH);

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    LanguageManager.shared.getLocale().then((locale) => setLocale(locale));
    BlocProvider.of<DrawerBloc>(context).add(GetTheme());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDo',
          theme: ThemeConfig.light().getTheme(_locale.languageCode),
          darkTheme: ThemeConfig.dark().getTheme(_locale.languageCode),
          themeMode:
              (state is GetThemeSuccess) ? state.themeMode : ThemeMode.system,
          initialRoute: '/',
          routes: {
            SplashScreen.routName: (context) => const SplashScreen(),
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
          home: const SplashScreen(),
        );
      },
    );
  }
}

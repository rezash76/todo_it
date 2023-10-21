import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/athentication/presentation/bloc/splash/bloc/splash_bloc.dart';
import 'package:todo_test/features/athentication/presentation/screen/signin_screen.dart';
import 'package:todo_test/features/athentication/presentation/screen/signup_screen.dart';
import 'package:todo_test/features/todo/presentation/screen/todo_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(UserIsExist());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TodoScreen(),
              ),
            );

            // TODO: implement Sign in/up
            //
            // if (state is SplashSeccessUserExist) {
            //   if (state.user.isLogin) {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const TodoScreen(),
            //       ),
            //     );
            //   } else {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const LoginScreen(),
            //       ),
            //     );
            //   }
            // }
            // if (state is SplashErrorUserExist) {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const SignupScreen(),
            //     ),
            //   );
            // }
          });
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 223, 0, 104),
                child: Center(
                  child: BlocBuilder<SplashBloc, SplashState>(
                    builder: (context, state) {
                      if (state is SplashLoading) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                      return Text(
                        LanguageManager.shared.translation(context).splashIntro,
                        style: themeData.textTheme.headlineLarge,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/login_signup/presentation/bloc/splash/bloc/splash_bloc.dart';
import 'package:todo_test/features/login_signup/presentation/screens/login_screen.dart';
import 'package:todo_test/features/login_signup/presentation/screens/signup_screen.dart';
import 'package:todo_test/features/todo/presentation/screens/home_screen.dart';

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
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (state is SplashSeccessUserExist) {
              if (state.user.isLogin) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            }
            if (state is SplashErrorUserExist) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              );
            }
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
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/features/login_signup/presentation/bloc/login/bloc/login_bloc.dart';
import 'package:todo_test/features/login_signup/presentation/widgets/down_login_widget.dart';
import 'package:todo_test/features/login_signup/presentation/widgets/up_login_widget.dart';
import 'package:todo_test/service_locator.dart';

class LoginScreen extends StatelessWidget {
  static String routName = '/login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(sl(), sl()),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                UpLogin(),
                DownLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

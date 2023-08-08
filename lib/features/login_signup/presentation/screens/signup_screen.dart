import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/features/login_signup/presentation/bloc/signup/bloc/signup_bloc.dart';
import 'package:todo_test/features/login_signup/presentation/widgets/down_signup_widget.dart';

import '../../../../service_locator.dart';
import '../widgets/up_login_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(sl()),
          child: const Column(
            children: [
              UpLogin(),
              SizedBox(
                height: 60,
              ),
              Expanded(child: SingleChildScrollView(child: DownSignup())),
            ],
          ),
        ),
      ),
    );
  }
}

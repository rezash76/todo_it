import 'package:flutter/material.dart';
import 'package:todo_test/features/athentication/presentation/widget/down_signup_widget.dart';
import 'package:todo_test/features/athentication/presentation/widget/up_login_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              UpLogin(),
              DownSignup(),
            ],
          ),
        ),
      ),
    );
  }
}

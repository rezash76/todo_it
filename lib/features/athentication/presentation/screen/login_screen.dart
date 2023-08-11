import 'package:flutter/material.dart';
import 'package:todo_test/features/athentication/presentation/widget/down_login_widget.dart';
import 'package:todo_test/features/athentication/presentation/widget/up_login_widget.dart';

class LoginScreen extends StatelessWidget {
  static String routName = '/login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              UpLogin(),
              DownLogin(),
            ],
          ),
        ),
      ),
    );
  }
}

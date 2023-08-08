import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/common/core/presentation/widget/custom_text_form_field.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/todo/presentation/screens/home_screen.dart';

import '../../domain/entities/value_object/signup_param.dart';
import '../bloc/signup/bloc/signup_bloc.dart';

class DownSignup extends StatefulWidget {
  const DownSignup({super.key});

  @override
  State<DownSignup> createState() => _DownSignupState();
}

class _DownSignupState extends State<DownSignup> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is SignupSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextFormField(
                    controller: firstnameController,
                    labelText:
                        LanguageManager.shared.translation(context).firstName,
                    hintText: LanguageManager.shared
                        .translation(context)
                        .firstNameHint,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextFormField(
                    controller: lastnameController,
                    labelText:
                        LanguageManager.shared.translation(context).lastName,
                    hintText: LanguageManager.shared
                        .translation(context)
                        .lastNameHint,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextFormField(
                    controller: usernameController,
                    labelText:
                        LanguageManager.shared.translation(context).username,
                    hintText: LanguageManager.shared
                        .translation(context)
                        .usernameHint,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    labelText:
                        LanguageManager.shared.translation(context).password,
                    hintText: LanguageManager.shared
                        .translation(context)
                        .passwordHint,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          final request = SignupRequest(
                            firstname: firstnameController.text,
                            lastname: lastnameController.text,
                            password: passwordController.text,
                            username: usernameController.text,
                          );
                          BlocProvider.of<SignupBloc>(context)
                              .add(Signup(request: request));
                        },
                        child: Text(
                          LanguageManager.shared.translation(context).signup,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

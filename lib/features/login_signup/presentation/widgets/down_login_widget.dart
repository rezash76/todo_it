import 'package:flutter/material.dart';
import 'package:todo_test/common/language_manager.dart';
import 'package:todo_test/features/login_signup/domain/entities/value_object/login_request.dart';
import 'package:todo_test/common/component/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/features/todo/presentation/screens/todo_screen.dart';
import '../bloc/login/bloc/login_bloc.dart';

class DownLogin extends StatefulWidget {
  const DownLogin({super.key});

  @override
  State<DownLogin> createState() => _DownLoginState();
}

class _DownLoginState extends State<DownLogin> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is LoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoScreen(),
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
                    obscureText: true,
                    maxLines: 1,
                    labelText:
                        LanguageManager.shared.translation(context).password,
                    hintText: LanguageManager.shared
                        .translation(context)
                        .passwordHint,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
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
                      if (usernameController.text != '' &&
                          passwordController.text != '') {
                        final param = LoginRequest(
                          usernameController.text,
                          passwordController.text,
                        );
                        BlocProvider.of<LoginBloc>(context)
                            .add(SignInEvent(param: param));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Fill all fields.',
                              style: themeData.textTheme.titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      LanguageManager.shared.translation(context).signin,
                      style: themeData.textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

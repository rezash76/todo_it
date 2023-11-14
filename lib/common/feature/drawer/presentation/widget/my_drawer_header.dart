import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_it/common/feature/drawer/presentation/bloc/drawer_bloc.dart';

class MyDrawerHeadet extends StatelessWidget {
  const MyDrawerHeadet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
      ),
      child: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (state is DrawerGetUserDataSuccess)
                    ? ('${state.user.name} ${state.user.family}')
                    : 'User Data',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                (state is DrawerGetUserDataSuccess)
                    ? (state.user.username)
                    : 'Username',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

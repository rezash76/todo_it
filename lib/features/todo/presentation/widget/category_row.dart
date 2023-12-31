import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/presentation/bloc/category/cat_bloc.dart';
import 'package:todo_it/features/todo/presentation/bloc/task/task_bloc.dart';
import 'package:todo_it/features/todo/presentation/widget/task_cat_icon.dart';

class CategoryRow extends StatefulWidget {
  final Function(TaskCategory cat) callback;
  const CategoryRow({
    super.key,
    required this.callback,
  });

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CatBloc>(context).add(GetCat());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatBloc, CatState>(
      builder: (context, state) {
        if (state is GetCatSuccess) {
          widget.callback(state.cat);
        }
        return Builder(builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TaskCatIcon(
                onTap: () => _onTap(TaskCategory.personal),
                category: TaskCategory.personal,
                isSelected: ((state is GetCatSuccess) &&
                    state.cat == TaskCategory.personal),
              ),
              TaskCatIcon(
                onTap: () => _onTap(TaskCategory.work),
                category: TaskCategory.work,
                isSelected: ((state is GetCatSuccess) &&
                    state.cat == TaskCategory.work),
              ),
              TaskCatIcon(
                onTap: () => _onTap(TaskCategory.shopping),
                category: TaskCategory.shopping,
                isSelected: ((state is GetCatSuccess) &&
                    state.cat == TaskCategory.shopping),
              ),
              TaskCatIcon(
                onTap: () => _onTap(TaskCategory.learning),
                category: TaskCategory.learning,
                isSelected: ((state is GetCatSuccess) &&
                    state.cat == TaskCategory.learning),
              ),
            ],
          );
        });
      },
    );
  }

  void _onTap(TaskCategory cat) {
    BlocProvider.of<CatBloc>(context).add(SetCat(
      cat,
    ));
    widget.callback(cat);
    BlocProvider.of<TaskBloc>(context).add(GetCatTasks(
      cat: cat,
    ));
  }
}

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test/common/constants.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/data/model/task_dto.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/data/datasource/local_datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';

base class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDatasource localDatasource;
  final SharedPreferences shared;

  TaskRepositoryImpl(this.localDatasource, this.shared);

  @override
  Future<Either<CacheException, List<TaskEntity>>> getAllTasks() async {
    try {
      var tasks = localDatasource.getAllTasks();
      return Right(returnTasksDependOnCat(tasks));
    } on NotFound {
      return Left(NotFound());
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, List<TaskEntity>>> addNewTask(
      TaskEntity taskEntity) async {
    try {
      var tasks = await localDatasource.addNewTask(taskEntity);
      await shared.setString(Constants.category, taskEntity.category.name);
      return Right(returnTasksDependOnCat(tasks));
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, List<TaskEntity>>> updateTask(
      TaskEntity taskEntity) async {
    try {
      var tasks = await localDatasource.updateTask(taskEntity);
      return Right(returnTasksDependOnCat(tasks));
    } on NotFound {
      return Left(NotFound());
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, List<TaskEntity>>> deleteTask(String id) async {
    try {
      var tasks = await localDatasource.deleteTask(id);
      return Right(returnTasksDependOnCat(tasks));
    } on NotFound {
      return Left(NotFound());
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, List<TaskEntity>>> getCatTasks(
      TaskCategory category) async {
    try {
      var tasks = localDatasource.getAllTasks();
      switch (category) {
        case TaskCategory.work:
          var workTasks = tasks
              .where((task) => task.category == TaskCategory.work)
              .toList();
          return workTasks.isNotEmpty ? Right(workTasks) : Left(NotFound());

        case TaskCategory.learning:
          var learningTasks = tasks
              .where((task) => task.category == TaskCategory.learning)
              .toList();
          return learningTasks.isNotEmpty
              ? Right(learningTasks)
              : Left(NotFound());

        case TaskCategory.shopping:
          var shoppingTasks = tasks
              .where((task) => task.category == TaskCategory.shopping)
              .toList();
          return shoppingTasks.isNotEmpty
              ? Right(shoppingTasks)
              : Left(NotFound());

        case TaskCategory.personal:
          var personalTasks = tasks
              .where((task) => task.category == TaskCategory.personal)
              .toList();
          return personalTasks.isNotEmpty
              ? Right(personalTasks)
              : Left(NotFound());
        default:
          // personal
          return Right(tasks);
      }
    } on NotFound {
      return Left(NotFound());
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, TaskCategory>> getCat() async {
    try {
      var cat = shared.getString(Constants.category);
      if (cat != null) {
        return switch (cat) {
          'work' => const Right(TaskCategory.work),
          'learning' => const Right(TaskCategory.learning),
          'shopping' => const Right(TaskCategory.shopping),
          'personal' => const Right(TaskCategory.personal),
          _ => const Right(TaskCategory.personal),
        };
      } else {
        return Left(CacheException());
      }
    } on Exception {
      return Left(CacheException());
    }
  }

  @override
  Future<Either<CacheException, TaskCategory>> setCat(
      TaskCategory category) async {
    try {
      await shared.setString(Constants.category, category.name);
      return getCat();
    } on Exception {
      return Left(CacheException());
    }
  }

  List<TaskDTO> returnTasksDependOnCat(List<TaskDTO> tasks) {
    var cat = shared.getString(Constants.category);
    if (cat != null) {
      return switch (cat) {
        'work' =>
          tasks.where((task) => task.category == TaskCategory.work).toList(),
        'learning' => tasks
            .where((task) => task.category == TaskCategory.learning)
            .toList(),
        'shopping' => tasks
            .where((task) => task.category == TaskCategory.shopping)
            .toList(),
        'personal' => tasks
            .where((task) => task.category == TaskCategory.personal)
            .toList(),
        _ => tasks,
      };
    } else {
      return tasks;
    }
  }
}

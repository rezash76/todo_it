import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test/common/constants.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/common/core/data/data_base/hive_task_db_provider.dart';
import 'package:todo_test/common/core/data/data_base/hive_user_db_provider.dart';
import 'package:todo_test/common/core/data/hive_model/hive_task.dart';
import 'package:todo_test/common/core/data/hive_model/hive_user.dart';
import 'package:todo_test/common/feature/drawer/data/datasource/drawer_datasource.dart';
import 'package:todo_test/common/feature/drawer/data/repository/drawer_repository_impl.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';
import 'package:todo_test/common/feature/drawer/domain/usecase/theme_usecase/get_theme_usecase.dart';
import 'package:todo_test/common/feature/drawer/domain/usecase/theme_usecase/set_theme_usecase.dart';
import 'package:todo_test/common/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:todo_test/features/login_signup/data/repositories/user_repository_impl.dart';
import 'package:todo_test/features/login_signup/domain/repositories/user_repository.dart';
import 'package:todo_test/features/login_signup/domain/usecases/login_usecase.dart';
import 'package:todo_test/features/login_signup/domain/usecases/logout_usecase.dart';
import 'package:todo_test/features/login_signup/domain/usecases/signup_usecase.dart';
import 'package:todo_test/features/login_signup/domain/usecases/splash_usecase.dart';
import 'package:todo_test/features/login_signup/presentation/bloc/signup/bloc/signup_bloc.dart';
import 'package:todo_test/features/login_signup/presentation/bloc/splash/bloc/splash_bloc.dart';
import 'package:todo_test/features/todo/data/datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/data/repository/task_repository_impl.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/usecase/add_new_usecase.dart';
import 'package:todo_test/features/todo/domain/usecase/delete_task_usecase.dart';
import 'package:todo_test/features/todo/domain/usecase/get_all_tasks_usecase.dart';
import 'package:todo_test/features/todo/domain/usecase/update_task_usecase.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';
import 'features/login_signup/data/datasource/local_ds/user_local_datasource.dart';
import 'features/login_signup/presentation/bloc/login/bloc/login_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserAdapter());
  Hive.registerAdapter(HiveTaskAdapter());
  await Hive.openBox(Constants.hiveUser);
  await Hive.openBox(Constants.hiveTask);

  // Datasource
  sl.registerLazySingleton<UserLocalDatasource>(
      () => UserLocalDatasourceImple(sl(instanceName: 'user')));
  sl.registerLazySingleton<TaskLocalDatasource>(
      () => TaskLocalDatasourceImpl(sl(instanceName: 'task')));
  sl.registerLazySingleton<DrawerDatasource>(
      () => DrawerDatasourceImpl(sl(instanceName: 'user'), sl()));

  // Data Base
  sl.registerLazySingleton<DBProvider>(() => HiveUserDBProvider(),
      instanceName: 'user');
  sl.registerLazySingleton<DBProvider>(() => HiveTaskDBProvider(),
      instanceName: 'task');
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(datasource: sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));
  sl.registerLazySingleton<DrawerRepository>(() => DrawerRepositoryImpl(sl()));

  // Usecase
  sl.registerLazySingleton(() => SplashUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetAllTasksUsecase(sl()));
  sl.registerLazySingleton(() => AddNewTaskUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => GetThemeUsecase(sl()));
  sl.registerLazySingleton(() => SetThemeUsecase(sl()));

  // Bloc
  sl.registerFactory(() => SplashBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl(), sl()));
  sl.registerFactory(() => SignupBloc(sl()));
  sl.registerFactory(() => TaskBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => DrawerBloc(sl(), sl()));
}

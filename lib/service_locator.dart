import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test/common/constants.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/features/todo/data/datasource/hive_task_db_provider/hive_task_db_provider.dart';
import 'package:todo_test/features/athentication/data/datasource/hive_user_db_provider/hive_user_db_provider.dart';
import 'package:todo_test/common/feature/drawer/data/datasource/drawer_datasource.dart';
import 'package:todo_test/common/feature/drawer/data/repository/drawer_repository_impl.dart';
import 'package:todo_test/common/feature/drawer/domain/repository/drawer_repository.dart';
import 'package:todo_test/common/feature/drawer/domain/transaction/theme_transaction/get_theme_transaction.dart';
import 'package:todo_test/common/feature/drawer/domain/transaction/theme_transaction/set_theme_transaction.dart';
import 'package:todo_test/common/feature/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:todo_test/features/athentication/data/model/hive/hive_user.dart';
import 'package:todo_test/features/athentication/data/repository/user_repository_impl.dart';
import 'package:todo_test/features/athentication/domain/repository/user_repository.dart';
import 'package:todo_test/features/athentication/domain/transaction/signin_transaction.dart';
import 'package:todo_test/features/athentication/domain/transaction/signout_transaction.dart';
import 'package:todo_test/features/athentication/domain/transaction/signup_transaction.dart';
import 'package:todo_test/features/athentication/domain/transaction/check_registration_transaction.dart';
import 'package:todo_test/features/athentication/presentation/bloc/signin/bloc/signin_bloc.dart';
import 'package:todo_test/features/athentication/presentation/bloc/signup/bloc/signup_bloc.dart';
import 'package:todo_test/features/athentication/presentation/bloc/splash/bloc/splash_bloc.dart';
import 'package:todo_test/features/todo/data/datasource/local_datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_test/features/todo/data/repository/task_repository_impl.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/transaction/add_new_task_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/category/set_cat_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/delete_task_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/get_all_tasks_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/get_cat_tasks_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/category/get_cat_transaction.dart';
import 'package:todo_test/features/todo/domain/transaction/update_task_transaction.dart';
import 'package:todo_test/features/todo/presentation/bloc/category/cat_bloc.dart';
import 'package:todo_test/features/todo/presentation/bloc/task/task_bloc.dart';
import 'features/athentication/data/datasource/local_datasource/user_local_datasource.dart';

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
  sl.registerLazySingleton<DrawerDatasource>(() => DrawerDatasourceImpl(sl()));

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
  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<DrawerRepository>(() => DrawerRepositoryImpl(sl()));

  // Usecase
  sl.registerLazySingleton(() => CheckRegistrationTransaction(sl()));
  sl.registerLazySingleton(() => SigninTransaction(repository: sl()));
  sl.registerLazySingleton(() => SignoutTransaction(repository: sl()));
  sl.registerLazySingleton(() => SignupTransaction(repository: sl()));
  sl.registerLazySingleton(() => GetAllTasksTransaction(sl()));
  sl.registerLazySingleton(() => GetCatTasksTransaction(sl()));
  sl.registerLazySingleton(() => AddNewTaskTransaction(sl()));
  sl.registerLazySingleton(() => UpdateTaskTransaction(sl()));
  sl.registerLazySingleton(() => DeleteTaskTransaction(sl()));
  sl.registerLazySingleton(() => GetThemeTransaction(sl()));
  sl.registerLazySingleton(() => SetThemeTransaction(sl()));
  sl.registerLazySingleton(() => GetCatTransaction(sl()));
  sl.registerLazySingleton(() => SetCatTransaction(sl()));

  // Bloc
  sl.registerFactory(() => SplashBloc(sl()));
  sl.registerFactory(() => SigninBloc(sl(), sl()));
  sl.registerFactory(() => SignupBloc(sl()));
  sl.registerFactory(() => TaskBloc(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => DrawerBloc(sl(), sl()));
  sl.registerFactory(() => CatBloc(sl(), sl()));
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/features/todo/data/datasource/local_datasource/task_local_datasource.dart';
import 'package:todo_it/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_it/features/todo/data/model/task_dto.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';

import 'mock_db_provider.mocks.dart';

void main() {
  late MockDBProvider mockDBProvider;
  late TaskLocalDatasourceImpl taskLocalDatasourceImpl;
  late Map<dynamic, dynamic> hiveMap;
  late Map<dynamic, dynamic> emptyMap;
  late List<TaskDTO> tasks;

  setUp(() {
    mockDBProvider = MockDBProvider();
    taskLocalDatasourceImpl = TaskLocalDatasourceImpl(mockDBProvider);
    hiveMap = {
      0: HiveTask(
          'id', 'title', 'desc', TaskCategory.personal.name, '32432412', true),
    };
    emptyMap = {};
    tasks = [
      TaskDTO(
          id: 'id',
          title: 'title',
          desc: 'desc',
          category: TaskCategory.personal,
          isCompleted: true,
          createTime: '12313123434'),
    ];
  });

  group('get all tasks', () {
    test('should return List<TaskDTO>.', () {
      when(mockDBProvider.getAll()).thenAnswer((_) => hiveMap);

      final result = taskLocalDatasourceImpl.getAllTasks();
      verify(mockDBProvider.getAll());
      expect(result, tasks);
      verifyNoMoreInteractions(mockDBProvider);
    });

    // test('should return NotFound Exception.', () {
    //   when(mockDBProvider.getAll()).thenAnswer((_) => emptyMap);

    //   final result = taskLocalDatasourceImpl.getAllTasks();
    //   verify(mockDBProvider.getAll());
    //   expect(() => result, throwsA(isA<NotFound>()));
    //   verifyNoMoreInteractions(mockDBProvider);
    // });
  });
}

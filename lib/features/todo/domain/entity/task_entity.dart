abstract base class TaskEntity {
  final String title;
  final String desc;
  bool isCompleted;

  TaskEntity(
    this.title,
    this.desc,
    this.isCompleted,
  );
}

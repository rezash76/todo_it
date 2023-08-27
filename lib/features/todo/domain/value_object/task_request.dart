base class TaskRequest {
  final String id;
  final String title;
  final String desc;
  final bool isCompleted;

  TaskRequest(
    this.id,
    this.title,
    this.desc,
    this.isCompleted,
  );
}

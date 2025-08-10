class Todo {
  final int id;
  final String task;
  final bool isCompleted;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.task,
    required this.isCompleted,
    required this.createdAt,
  });

  // JSON에서 Todo 객체로 변환하기 위한 팩토리 생성자
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      task: json['task'] as String,
      isCompleted: json['is_completed'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

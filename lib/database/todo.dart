const String tableTodos = 'todos';

// All fields
class TodoFields {
  static final List<String> values = [id, task, isCompleted, isImportant, sortOrder];

  static const String id = '_id';
  static const String task = 'task';
  static const String isCompleted = 'isCompleted';
  static const String isImportant = 'isImportant';
  static const String sortOrder = 'sortOrder';
}

// todo model
class Todo {
  final int? id;
  final String task;
  final bool isCompleted;
  final bool isImportant;
  final int sortOrder;

  const Todo({
    this.id,
    required this.task,
    required this.isCompleted,
    required this.isImportant,
    required this.sortOrder,
  });

  // copy todo (use: without id => with id)
  Todo copy({
    int? id,
    String? task,
    bool? isCompleted,
    bool? isImportant,
    int? sortOrder,
  }) =>
      Todo(
        id: id ?? this.id,
        task: task ?? this.task,
        isCompleted: isCompleted ?? this.isCompleted,
        isImportant: isImportant ?? this.isImportant,
        sortOrder: sortOrder ?? this.sortOrder,
      );

  // convert json to object
  static Todo fromJson(Map<String, Object?> json) => Todo(
        id: json[TodoFields.id] as int?,
        task: json[TodoFields.task] as String,
        isCompleted: json[TodoFields.isCompleted] == 1,
        isImportant: json[TodoFields.isImportant] == 1,
        sortOrder: json[TodoFields.sortOrder] as int,
      );

  // convert object to json
  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.task: task,
        TodoFields.isCompleted: isCompleted ? 1 : 0,
        TodoFields.isImportant: isImportant ? 1 : 0,
        TodoFields.sortOrder: sortOrder,
      };
}

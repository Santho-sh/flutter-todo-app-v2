import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';

class TodosDatabase {
  static final TodosDatabase instance = TodosDatabase._init();

  static Database? _database;

  TodosDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    return _database!;
  }

  // initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<int> getTotalTodosCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $tableTodos');
    final count = Sqflite.firstIntValue(result)!;
    return count;
  }

  // create todo table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableTodos(
        ${TodoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TodoFields.task} TEXT NOT NULL,
        ${TodoFields.isCompleted} BOOLEAN NOT NULL,
        ${TodoFields.isImportant} BOOLEAN NOT NULL,
        ${TodoFields.sortOrder} INTEGER NOT NULL
      ) 
      ''');
  }

  // create new todo
  Future<Todo> create(Todo todo) async {
    final db = await instance.database;

    final id = await db.insert(
      tableTodos,
      todo.toJson(),
    );
    return todo.copy(id: id);
  }

  // update todo
  Future update(Todo todo) async {
    final db = await instance.database;

    return db.update(
      tableTodos,
      todo.toJson(),
      where: '${TodoFields.id} = ?',
      whereArgs: [todo.id],
    );
  }

  // reorder todos
  Future<void> reorder(int oldIndex, int newIndex) async {
    final db = await instance.database;

    if (oldIndex < newIndex) {
      newIndex--;
    }

    final query1 = await db.query(
      tableTodos,
      columns: TodoFields.values,
      where: '${TodoFields.sortOrder} = ?',
      whereArgs: [newIndex],
    );

    final query2 = await db.query(
      tableTodos,
      columns: TodoFields.values,
      where: '${TodoFields.sortOrder} = ?',
      whereArgs: [oldIndex],
    );

    final newIndexTodo = Todo.fromJson(query1.first);
    final oldIndexTodo = Todo.fromJson(query2.first);

    await db.update(
      tableTodos,
      newIndexTodo.copy(sortOrder: oldIndex).toJson(),
      where: '${TodoFields.sortOrder} = ?',
      whereArgs: [oldIndex],
    );

    await db.update(
      tableTodos,
      oldIndexTodo.copy(sortOrder: newIndex).toJson(),
      where: '${TodoFields.sortOrder} = ?',
      whereArgs: [newIndex],
    );
  }

  // delete todo
  Future delete(int id) async {
    final db = await instance.database;

    return db
        .delete(tableTodos, where: '${TodoFields.id} = ?', whereArgs: [id]);
  }

  // Active Todos
  Future<List<Todo>?> activeTodos() async {
    final db = await instance.database;

    final query = await db.query(
      tableTodos,
      columns: TodoFields.values,
      where: '${TodoFields.isCompleted} = ?',
      orderBy: TodoFields.sortOrder,
      whereArgs: [0],
    );

    if (query.isNotEmpty) {
      return query.map((json) => Todo.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  // Completed Todos
  Future<List<Todo>?> completedTodos() async {
    final db = await instance.database;

    final query = await db.query(
      tableTodos,
      columns: TodoFields.values,
      where: '${TodoFields.isCompleted} = ?',
      orderBy: TodoFields.sortOrder,
      whereArgs: [1],
    );

    if (query.isNotEmpty) {
      return query.map((json) => Todo.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  // Close database connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

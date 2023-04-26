import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_shared_preferences.dart';
import 'package:todo_app_v2/database/todo.dart';
import 'package:todo_app_v2/database/todos_database.dart';

class AppState extends ChangeNotifier {
  // for dark mode
  late bool _isDark;
  late SharedPreferences prefs;
  late ThemeSharedPreferences themeSharedPreferences;
  bool get isDark => _isDark;

  List<Todo> activeTodos = [];
  List<Todo> completedTodos = [];

  Color currentTheme = Colors.black;

  AppState() {
    _init();
  }

  void _init() async {
    _isDark = false;
    themeSharedPreferences = ThemeSharedPreferences();
    await getThemePreferences();
    getTodos();
  }

  set isDark(bool value) {
    _isDark = value;
    themeSharedPreferences.setTheme(value);
    notifyListeners();
  }

  getThemePreferences() async {
    _isDark = await themeSharedPreferences.getTheme();
    notifyListeners();
  }

  // get todos from db
  void getTodos() async {
    activeTodos = (await TodosDatabase.instance.activeTodos()) ?? [];
    completedTodos = (await TodosDatabase.instance.completedTodos()) ?? [];
    notifyListeners();
  }

  // reorder active todos
  void changeIndex(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = activeTodos.removeAt(oldIndex);
    activeTodos.insert(newIndex, item);
    notifyListeners();

    await TodosDatabase.instance.reorder(activeTodos);
    getTodos();
  }

  // change IsImportant value
  void changeIsImportant(Todo todo, List<Todo> list) async {
    final index = todo.isImportant ? list.length - 1 : 0;
    final item = list.removeAt(todo.sortOrder);

    list.insert(index, item.copy(isImportant: todo.isImportant ? false : true));
    await TodosDatabase.instance.reorder(list);
    getTodos();
  }

  // Craete new todo on top
  Future<int> createTodo(String task) async {
    if (task.trim() == '') {
      return 0;
    }

    final todo = Todo(
      task: task.trim(),
      isCompleted: false,
      isImportant: false,
      sortOrder: 0,
    );
    activeTodos.insert(0, todo);
    notifyListeners();

    await TodosDatabase.instance.create(todo);
    await TodosDatabase.instance.reorder(activeTodos);
    getTodos();
    return 1;
  }

  // undo todo
  void undoTodo(Todo todo) async {
    await TodosDatabase.instance.create(todo);
    getTodos();
  }

  // delete todo
  void deleteTodo(Todo todo) async {
    await TodosDatabase.instance.delete(todo.id!);
    if (todo.isCompleted) {
      completedTodos.remove(todo);
      await TodosDatabase.instance.reorder(completedTodos);
    } else {
      activeTodos.remove(todo);
      await TodosDatabase.instance.reorder(activeTodos);
    }
    getTodos();
  }

  // change IsCompleted value
  void changeIsComplete(Todo todo) async {
    if (activeTodos.contains(todo)) {
      completedTodos.add(todo.copy(isCompleted: true));
      activeTodos.remove(todo);
    } else {
      activeTodos.add(todo.copy(isCompleted: false));
      completedTodos.remove(todo);
    }
    await TodosDatabase.instance
        .update(todo.copy(isCompleted: !todo.isCompleted));
    await TodosDatabase.instance.reorder(activeTodos);
    await TodosDatabase.instance.reorder(completedTodos);

    getTodos();
  }
}

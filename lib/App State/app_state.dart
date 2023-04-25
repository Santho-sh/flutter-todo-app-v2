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

  List<Todo> activeStaredTodos = [];
  List<Todo> activeUnstaredTodos = [];
  List<Todo> completedStaredTodos = [];
  List<Todo> completedUnstaredTodos = [];

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

  void getTodos() async {
    activeStaredTodos =
        (await TodosDatabase.instance.activeStaredTodos()) ?? [];
    activeUnstaredTodos =
        (await TodosDatabase.instance.activeUnstaredTodos()) ?? [];
    completedStaredTodos =
        (await TodosDatabase.instance.completedStaredTodos()) ?? [];
    completedUnstaredTodos =
        (await TodosDatabase.instance.completedUnstaredTodos()) ?? [];
    notifyListeners();
  }

  // reorder list
  void changeIndex(int oldIndex, int newIndex) {
    TodosDatabase.instance.reorder(oldIndex, newIndex);
    getTodos();
  }

  // Craete new todo
  Future<int> createTodo(String task) async {
    if (task.trim() == '') {
      return 0;
    }
    final lenth = await TodosDatabase.instance.getTotalTodosCount();
    final todo = Todo(
      task: task.trim(),
      isCompleted: false,
      isImportant: false,
      sortOrder: lenth,
    );
    TodosDatabase.instance.create(todo);
    getTodos();
    return 1;
  }

  void undoTodo(Todo todo) {
    TodosDatabase.instance.create(todo);
    getTodos();
  }

  void deleteTodo(int id) {
    TodosDatabase.instance.delete(id);
    getTodos();
  }

  void changeIsComplete(Todo todo) {
    TodosDatabase.instance
        .update(todo.copy(isCompleted: todo.isCompleted ? false : true));
    getTodos();
  }

  void changeIsImportant(Todo todo) {
    TodosDatabase.instance
        .update(todo.copy(isImportant: todo.isImportant ? false : true));
    getTodos();
  }
}

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

  void getTodos() async {
    activeTodos = (await TodosDatabase.instance.activeTodos()) ?? [];
    completedTodos = (await TodosDatabase.instance.completedTodos()) ?? [];

    for (var to in activeTodos) {
      print(to.task);
      print(to.sortOrder);
    }
    print('-------------');
    for (var to in completedTodos) {
      print(to.task);
      print(to.sortOrder);
    }
    notifyListeners();
  }

  // reorder list
  void changeIndex(int oldIndex, int newIndex, List<Todo> list) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    TodosDatabase.instance.reorder(list);
  }

  // Change: Important or not
  void changeIsImportant(Todo todo) async {
    await TodosDatabase.instance
        .update(todo.copy(isImportant: !todo.isImportant));

    if (!todo.isCompleted) {
      changeIndex(todo.sortOrder, 0, activeTodos);
    } else {
      changeIndex(todo.sortOrder, 0, completedTodos);
    }

    getTodos();
  }

  // Craete new todo
  Future<int> createTodo(String task) async {
    if (task.trim() == '') {
      return 0;
    }

    final todo = Todo(
      task: task.trim(),
      isCompleted: false,
      isImportant: false,
      sortOrder: activeTodos.length,
    );
    await TodosDatabase.instance.create(todo);
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

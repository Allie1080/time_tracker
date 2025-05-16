import "package:flutter/foundation.dart";
import "package:localstorage/localstorage.dart";
import "package:provider/provider.dart";

import "dart:convert";

import "../models/time_entry.dart";
import "../models/project.dart";
import "../models/task.dart";
import "../constants/basic.dart";

class AppProvider with ChangeNotifier {
  final LocalStorage storage;

  List<Project> _projects = [];
  List<Project> get  projects => _projects;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  List<TimeEntry> _entries = [];
  List<TimeEntry> get entries => _entries;

  AppProvider(this.storage) {
    // _deleteAllStorage();
    _loadFromStorage();

  }

  void _loadFromStorage() async {
    var storedProjects = jsonDecode(storage.getItem('projects') ?? "[]");
    var storedTasks = jsonDecode(storage.getItem('tasks') ?? "[]");
    var storedEntries = jsonDecode(storage.getItem('entries') ?? "[]");

    if (storedProjects != null) {
      _projects = List<Project>.from(
        (storedProjects as List).map((item) => Project.fromJson(item)),
      );
    
    }

    if (storedTasks != null) {
      _tasks = List<Task>.from(
        (storedTasks as List).map((item) => Task.fromJson(item)),
      );
    
    }
    
    if (storedEntries != null) {
      _entries = List<TimeEntry>.from(
        (storedEntries as List).map((item) => TimeEntry.fromJson(item)),
      );
  
    }

    notifyListeners();
  
  }

  void _saveProjectsToStorage() async {
    storage.setItem("projects", jsonEncode(_projects.map((project) => project.toJson()).toList()));
    
  }
  
  void _saveTasksToStorage() async {
    storage.setItem("tasks", jsonEncode(_tasks.map((task) => task.toJson()).toList()));

  }
  
  void _saveEntriesToStorage() async {
    storage.setItem("entries", jsonEncode(_entries.map((entry) => entry.toJson()).toList()));

  }
  
  void _saveToStorage() async {
    _saveProjectsToStorage();
    _saveTasksToStorage();
    _saveEntriesToStorage();

  }

  void _deleteAllStorage() async {
    storage.removeItem("entries");
    storage.removeItem("tasks");
    storage.removeItem("projects");

  }
  

  void addTimeEntry({
    required int projectId,
    required int taskId,
    required double totalTime,
    required DateTime date,
    required String notes
  }) {
    _entries.add(TimeEntry(
      id: (_entries.isEmpty) ? 0 : _entries.last.id + 1,
      projectId: projectId,
      taskId: taskId,
      totalTime: totalTime,
      date: date,
      notes: notes
      ));

    _saveEntriesToStorage();
    notifyListeners();

  }

  void deleteTimeEntry(int id) {
    _entries.removeWhere((entry) => entry.id == id);
    _saveEntriesToStorage();
    notifyListeners();

  }

  void addTask(String name) {
    name = _checkDuplicateName(name, _tasks);

    _tasks.add(Task(
      id: (_tasks.isEmpty) ? 0 : _tasks.last.id + 1,
      name: name));
    
    _saveTasksToStorage();
    notifyListeners();

  }

  void updateTaskName(int id, String newName) {
    newName = _checkDuplicateName(newName, _tasks);

    _tasks.firstWhere((task) => task.id == id).name = newName;

    _saveTasksToStorage();
    notifyListeners();

  }

  void deleteTask(int id) {
    for (var entry in _entries) {
      if (entry.taskId == id) {
        _entries.remove(entry);
        notifyListeners();

      }

    }
    
    _tasks.removeWhere((task) => task.id == id);
    _saveTasksToStorage();
    notifyListeners();

  }

  void addProject(String name) {
    name = _checkDuplicateName(name, _projects);

    _projects.add(Project(
      id: (_projects.isEmpty) ? 0 : _projects.last.id + 1,
      name: name));

    _saveProjectsToStorage();
    notifyListeners();

  }

  void updateProjectName(int id, String newName) {
    newName = _checkDuplicateName(newName, _projects);

    _projects.firstWhere((project) => project.id == id).name = newName;

    _saveProjectsToStorage();
    notifyListeners();

  }

  void deleteProject(int id) {
    for (var entry in _entries) {
      if (entry.projectId == id) {
        _entries.remove(entry);
        notifyListeners();

      }

    }
    
    _tasks.removeWhere((project) => project.id == id);
    _saveProjectsToStorage();
    notifyListeners();

  }

  String _checkDuplicateName(String name, List<dynamic> existingInstances) { 
    String temp = name;
    bool isNew = false;

    if (const <String>[newProjectName, newTaskName].contains(name)) {
      name = "$name (1)";
      isNew = true;

    }

    for (int occurences = (isNew) ? 2 : 1; existingInstances.any((item) => item.name == name); occurences++) {
      name = "$temp ($occurences)";  

    }

    return name;

  }
}
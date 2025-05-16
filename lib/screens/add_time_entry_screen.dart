import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../models/time_entry.dart";
import "../models/project.dart";
import "../models/task.dart";
import "../providers/project_task_provider.dart";

import "../consts.dart";

class AddTimeEntryScreen extends StatefulWidget {
  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();

}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Project> projects = [];
  List<Task> tasks = [];
  
  int projectId = 0;
  int taskId = 0;
  
  double totalTime = 0.0;
  DateTime date = DateTime.now();
  String notes = "";


  @override
  Widget build(BuildContext context) {
    //projectChoices.addAll([]);
    if (projects.isEmpty) {
      projects.addAll(Provider.of<AppProvider>(context, listen: false).projects);
      projects.insert(0, Project(id: newObjectId, name: newProjectName));
      projectId = projects[0].id;

    } 
    
    if (tasks.isEmpty) {
      tasks.addAll(Provider.of<AppProvider>(context, listen: false).tasks);
      tasks.insert(0, Task(id: newObjectId, name: newTaskName));
      taskId = tasks[0].id;

    }



    // print("line 43: ${projects.map((projects) => projects.toJson())}");
    // print("line 44: ${projects.map((project) => project.id)}");
    // print("line 45: ${tasks.map((projects) => projects.toJson())}");
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Time Entry"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            DropdownButtonFormField<int>(
              value: projectId,
              onChanged: (int? newValue) {
                setState(() {
                  projectId = newValue!;
                });
              },
              decoration: InputDecoration(labelText: "Project"),
              items: projects.map((project) => project.id)
              .map<DropdownMenuItem<int>>((int id) {
                return DropdownMenuItem<int>(
                  value: id,
                  child: Text(projects.firstWhere((project) => project.id == id).name)
                );
              }).toList(),
            ),
            DropdownButtonFormField<int>(
              value: taskId,
              onChanged: (int? newValue) {
                setState(() {
                  taskId = newValue!;
                });
              },
              decoration: InputDecoration(labelText: "Task"),
              items: tasks.map((task) => task.id)
                .map<DropdownMenuItem<int>>((int id) {
                return DropdownMenuItem<int>(
                  value: id,
                  child: Text(tasks.firstWhere((task) => task.id == id).name),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Total Time (hours)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter total time";
                }
                if (double.tryParse(value) == null) {
                  return "Please enter a valid number";
                }
                return null;
              },
              onSaved: (value) => totalTime = double.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Notes"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some notes";
                }
                return null;
              },
              onSaved: (value) => notes = value!,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (projectId == newObjectId) {
                    Provider.of<AppProvider>(context, listen: false)
                      .addProject(newProjectName);

                  }

                  if (taskId == newObjectId) {
                    Provider.of<AppProvider>(context, listen: false)
                      .addTask(newTaskName);

                  }

                  Provider.of<AppProvider>(context, listen: false)
                      .addTimeEntry( // Simple ID generation
                    projectId: (projectId != newObjectId) ? projectId : Provider.of<AppProvider>(context, listen: false).projects.last.id,
                    taskId: (taskId != newObjectId) ? taskId : Provider.of<AppProvider>(context, listen: false).tasks.last.id,
                    totalTime: totalTime,
                    date: date,
                    notes: notes,
                  );

                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}

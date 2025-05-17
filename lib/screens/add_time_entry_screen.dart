import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:intl/intl.dart";

import "../models/time_entry.dart";
import "../models/project.dart";
import "../models/task.dart";

import "../providers/project_task_provider.dart";

import "home_screen.dart";

import "../widgets/edit_item_dialog.dart";

import "../constants/basic.dart";
import "../constants/colors.dart";

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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      builder:(context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: swamp, 
              onPrimary: white, 
              onSurface: swamp,
              secondary: swamp,
              onSecondary: white,
              outline: swamp
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: white,
                backgroundColor: swamp
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.fromDateTime(date),
    );
    if (picked != null) {
      setState(() {
        date = DateTime(
          date.year,
          date.month,
          date.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder:(context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: swamp, 
              onPrimary: white, 
              onSurface: swamp,
              secondary: swamp,
              onSecondary: bog,
              outline: swamp, 
              outlineVariant: swamp 
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: white,
                backgroundColor: swamp
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      firstDate: DateTime.utc(0, 0, 0),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        date = DateTime(
          picked.year,
          picked.month,
          picked.day,
          date.hour,
          date.minute,
        );
      });
    }
  }


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
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement( // dont touch this, dont use pop, it"ll cause bugs with the task/project deletion feature
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen()
              )); 
            }, 
          icon: const Icon(Icons.arrow_back, color: white)
            ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: Column(
            // spacing: 10.0, messes with SizedBoxes
            children: <Widget>[
              const SizedBox(height: 12.0),
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
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Date",
                          labelStyle: TextStyle(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: black),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: swamp, width: 2.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(DateFormat("MMM d, y").format(date), style: TextStyle(color: black)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Time",
                          labelStyle: TextStyle(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: black),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: swamp, width: 2.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(DateFormat("h:mm a").format(date), style: TextStyle(color: black)),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 12.0),
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
              const SizedBox(height: 10.0),
              TextFormField(
                maxLines: 3,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(labelText: "Notes"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some notes";
                  }
                  return null;
                },
                onSaved: (value) => notes = value!,
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                style: ButtonStyle(),
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

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen())
                    );
                  }
                },
                child: Text("Add"),
              )
            ],
          ),
        ),
      )
    );
  }
}

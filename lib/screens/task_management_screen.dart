import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "package:intl/intl.dart";

import '../models/project.dart';
import '../models/task.dart';
import '../providers/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects and Tasks'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              final entry = provider.entries[index];
              final task = provider.tasks.firstWhere((task) => task.id == entry.taskId);
              final project = provider.projects.firstWhere((project) => project.id == entry.projectId);
              return ListTile(
                title: Text("${project.name.toUpperCase()} - ${task.name}"),
                subtitle:
                    Text(
                    "Total Time: ${entry.totalTime} hours\n"
                    "${DateFormat.yMMMd().add_jm().format(entry.date)}\n"
                    "Notes: ${entry.notes}"),
                onTap: () {
                  // This could open a detailed view or edit screen
                },
              );
            },
          );
          // Lists for managing projects and tasks would be implemented here
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new project or task
        },
        child: Icon(Icons.add),
        tooltip: 'Add Project/Task',
      ),
    );
  }
}

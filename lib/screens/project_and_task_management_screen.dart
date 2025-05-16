import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_tracker/screens/home_screen.dart';
import 'package:time_tracker/widgets/confirm_delete_dialog.dart';

import "../constants/basic.dart";
import "../constants/colors.dart";

import "../widgets/empty_screen_text_builder.dart";
import "../widgets/edit_item_dialog.dart";
import '../providers/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatefulWidget {
  final int initialTab;

  ProjectTaskManagementScreen({super.key, required this.initialTab});

  @override
  State<ProjectTaskManagementScreen> createState() => _ProjectTaskManagementState();

}

class _ProjectTaskManagementState extends State<ProjectTaskManagementScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: widget.initialTab, length: 2, vsync: this);

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    TextEditingController editController;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects and Tasks'),
        backgroundColor: night,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement( // dont touch this, dont use pop, it'll cause bugs with the task/project deletion feature
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen()
              )); 
            }, 
          icon: const Icon(Icons.arrow_back, color: white)
            ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: shade,
          labelColor: shade,
          unselectedLabelColor: white,
          tabs: const [
            Tab(
              text: 'Projects',
            ),
            Tab(
              text: 'Tasks',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer<AppProvider>(
            builder: (context, provider, child) {
              return 
              (provider.projects.isEmpty) ? 
              buildEmptyScreenText(
                text: "You don't have any projects yet!",
                subtitle: "Tap the '+' button to add your first project."
              ) : 
              ListView.builder(
                itemCount: provider.projects.length,
                itemBuilder: (context, index) {
                  final project = provider.projects[index];

                  return ListTile(
                    title: Text(project.name),
                    onTap: () {
                      editController = TextEditingController(text: project.name);
                      buildEditItemDialog(
                        context, 
                        provider, 
                        editController, 
                        "Edit Project Name", 
                        "Type new project name", 
                        project.id,
                        ItemTypes.project
                      );

                    },
                    trailing: IconButton(
                        icon: const Icon(Icons.delete, color: red),
                        onPressed: () {
                          setState(() {
                            buildConfirmDeletionDialog(
                              context, 
                              provider, 
                              "Project Deletion", 
                              "Are you sure you want to delete this project? All associated entries will disappear along with it.", 
                              project.id, 
                              ItemTypes.project);
              
                            }
                          );
                        }
                      ),
                  );
                },
              );
              // Lists for managing projects and tasks would be implemented here
            },
          ),
          Consumer<AppProvider>(
            builder: (context, provider, child) {
              return
              (provider.tasks.isEmpty) ?  
              buildEmptyScreenText(
                text: "You don't have any tasks yet!",
                subtitle: "Tap the '+' button to add your first task."
              ) : 
              ListView.builder(
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  final task = provider.tasks[index];

                  return ListTile(
                    title: Text(task.name),
                    onTap: () {
                      editController = TextEditingController(text: task.name);

                      buildEditItemDialog(
                        context, 
                        provider, 
                        editController, 
                        "Edit Task Name", 
                        "Type new task name", 
                        task.id,
                        ItemTypes.task
                      );                    
                    },
                    trailing: IconButton(
                        icon: const Icon(Icons.delete, color: red),
                        onPressed: () {
                          setState( () {
                            buildConfirmDeletionDialog(
                              context, 
                              provider, // Provider.of<AppProvider>(context), 
                              "Task Deletion", 
                              "Are you sure you want to delete this task? All associated entries will disappear along with it.", 
                              task.id, 
                              ItemTypes.project);

                            }
                          );
                        }
                      ),
                  );
                },
              );
              // Lists for managing projects and tasks would be implemented here
            },
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: night,
        onPressed: () {
          
        },
        child: Icon(Icons.add),
        tooltip: 'Add Project/Task',
      ),
    );
  }
}

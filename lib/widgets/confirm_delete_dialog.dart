import "package:flutter/material.dart";

import "../constants/basic.dart";
import "../constants/colors.dart";

import "../providers/project_task_provider.dart";

Future<dynamic> buildConfirmDeletionDialog(
  BuildContext context, 
  AppProvider provider, 
  String title, 
  String boxText,
  int id,
  ItemTypes itemType) {

  return showDialog(
      context: context,
      builder: (context) => 
        AlertDialog(
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text(boxText),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: white,
                  foregroundColor: black,
                ), 
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: white,
                ),
                child: Text("Delete"),
                onPressed: () {
                  late final String itemName; 

                  switch (itemType) {
                    case ItemTypes.project:
                      itemName = provider.projects.firstWhere((project) => project.id == id).name;
                      provider.deleteProject(id);
                      break;
                    
                    case ItemTypes.task:
                      itemName = provider.tasks.firstWhere((task) => task.id == id).name;
                      provider.deleteTask(id);
                      break;
                    
                    case ItemTypes.timeEntry:
                      itemName = "Entry";
                      provider.deleteTimeEntry(id);
                      break;
                  
                  }
                  
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$itemName Deleted', style: TextStyle()),
                    ),
                  );
                },
              ),
            ],
          )
  );
}
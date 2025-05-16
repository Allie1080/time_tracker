import "package:flutter/material.dart";

import "../constants/basic.dart";
import "../constants/colors.dart";

import "../providers/project_task_provider.dart";

Future<dynamic> buildEditItemDialog(
  BuildContext context, 
  AppProvider provider,  
  TextEditingController controller,
  String title,
  String hintText,
  int id,
  ItemTypes itemType) {

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextFormField(
          maxLength: 1 << 4,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: black,
            ),
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text("Save", style: TextStyle()),
            onPressed: () {
              switch (itemType) {
                case ItemTypes.project:
                  provider.updateProjectName(id, controller.text);
                  break;
                
                case ItemTypes.task:
                  provider.updateTaskName(id, controller.text);
                  break;
                
                case ItemTypes.timeEntry:
                  print("No");
                  break;
              
              }

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );

}
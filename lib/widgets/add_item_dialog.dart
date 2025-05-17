import "package:flutter/material.dart";

import "../constants/basic.dart";
import "../constants/colors.dart";

import "../providers/project_task_provider.dart";

Future<dynamic> buildAddItemDialog(
  BuildContext context, 
  AppProvider provider,  
  TextEditingController controller,
  String title,
  String hintText,
  ItemTypes itemType) {

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextFormField(
          maxLength: 32,
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
              backgroundColor: orange,
              foregroundColor: white,
            ),
            child: Text("Add", style: TextStyle()),
            onPressed: () {
              switch (itemType) {
                case ItemTypes.project:
                  provider.addProject(controller.text);
                  break;
                
                case ItemTypes.task:
                  provider.addTask(controller.text);
                  break;
                
                case ItemTypes.timeEntry:
                  print("This will never be used for that");
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
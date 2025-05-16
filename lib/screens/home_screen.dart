import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:intl/intl.dart";
import "package:time_tracker/consts.dart";

import "../models/time_entry.dart";
import "../providers/project_task_provider.dart";

import "add_time_entry_screen.dart";

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomePageState();

}

class _HomePageState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();

  }


  // Widget _buildEntryTab(List<TimeEntry> entryGroup, AppProvider provider) {
  //   return Consumer<AppProvider>(
  //       builder: (context, provider, child) {
  //         return ListView.builder(
  //           itemCount: entryGroup.length,
  //           itemBuilder: (context, index) {
  //             final entry = entryGroup[index];
  //             final task = provider.tasks.firstWhere((task) => task.id == entry.taskId);
  //             final project = provider.projects.firstWhere((project) => project.id == entry.projectId);

  //             return Card( 
  //               shadowColor: bog,
  //               child: ListTile(
  //                   title: RichText(
  //                     text: TextSpan(
  //                       style: const TextStyle(
  //                         color: black,
  //                         fontSize: 18.0
  //                       ),
  //                       children: [
  //                         TextSpan(
  //                           text: "[${project.name.toUpperCase()}] ",
  //                           style: const TextStyle(fontWeight: FontWeight.bold) 
  //                         ),
  //                         TextSpan(text: "${task.name}")

  //                       ]
  //                     )
  //                   ),
  //                   subtitle:
  //                       Text(
  //                       "Total Time: ${entry.totalTime} hours\n"
  //                       "${DateFormat.yMMMd().add_jm().format(entry.date)}\n"
  //                       "Notes: ${entry.notes}"),
  //                   trailing: 
  //                     IconButton(
  //                       icon: const Icon(Icons.delete, color: red),
  //                       onPressed: () {
                          
  //                       } 
  //                   ),
  //                   subtitleTextStyle: TextStyle(
  //                     color: gray,
  //                     fontSize: 12.0
  //                   ),
  //                   enabled: true,
  //                   onTap: () {
  //                     // This could open a detailed view or edit screen
  //                   },
  //                   onLongPress: () {
  //                     isDeleteMode = true;
  //                   },
  //                 )
  //               );
  //           },
  //         );
  //       },
  //     )

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Entries"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: white, size: 20.0),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )
          )
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: bog,
          labelColor: bog,
          unselectedLabelColor: white,
          tabs: const [
            Tab(
              text: 'All Entries',
            ),
            Tab(
              text: 'Entries Grouped by Project',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer<AppProvider>(
            builder: (context, provider, child) {
              return (provider.entries.isEmpty) ? 
              Center(child: Text("You don't have entries yet", style: const TextStyle(color: gray, fontSize: 23))) :
              ListView.builder(
                itemCount: provider.entries.length,
                itemBuilder: (context, index) {
                  final entry = provider.entries[index];
                  final task = provider.tasks.firstWhere((task) => task.id == entry.taskId);
                  final project = provider.projects.firstWhere((project) => project.id == entry.projectId);

                  return Card( 
                    shadowColor: bog,
                    child: ListTile(
                        title: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: black,
                              fontSize: 18.0
                            ),
                            children: [
                              TextSpan(
                                text: "[${project.name.toUpperCase()}] ",
                                style: const TextStyle(fontWeight: FontWeight.bold) 
                              ),
                              TextSpan(text: "${task.name}")

                            ]
                          )
                        ),
                        subtitle:
                            Text(
                            "Total Time: ${entry.totalTime} hours\n"
                            "${DateFormat.yMMMd().add_jm().format(entry.date)}\n"
                            "Notes: ${entry.notes}"),
                        trailing: 
                          IconButton(
                            icon: const Icon(Icons.delete, color: red),
                            onPressed: () {
                              
                            } 
                        ),
                        subtitleTextStyle: TextStyle(
                          color: gray,
                          fontSize: 12.0
                        ),
                        enabled: true,
                        onTap: () {
                          // This could open a detailed view or edit screen
                        },
                        onLongPress: () {
                        },
                      )
                    );
                },
              );
            },
          ),
          Consumer<AppProvider>(
            builder: (context, provider, child) {
              return (provider.entries.isEmpty) ? 
              Center(child: Text("You don't have entries yet", style: const TextStyle(color: gray, fontSize: 23))) :
              ListView.builder(
                itemCount: provider.entries.length,
                itemBuilder: (context, index) {
                  final entry = provider.entries[index];
                  final task = provider.tasks.firstWhere((task) => task.id == entry.taskId);
                  final project = provider.projects.firstWhere((project) => project.id == entry.projectId);

                  return Card( 
                    shadowColor: bog,
                    child: ListTile(
                        title: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: black,
                              fontSize: 18.0
                            ),
                            children: [
                              TextSpan(
                                text: "[${project.name.toUpperCase()}] ",
                                style: const TextStyle(fontWeight: FontWeight.bold) 
                              ),
                              TextSpan(text: "${task.name}")

                            ]
                          )
                        ),
                        subtitle:
                            Text(
                            "Total Time: ${entry.totalTime} hours\n"
                            "${DateFormat.yMMMd().add_jm().format(entry.date)}\n"
                            "Notes: ${entry.notes}"),
                        trailing: 
                          IconButton(
                            icon: const Icon(Icons.delete, color: red),
                            onPressed: () {
                              
                            } 
                        ),
                        subtitleTextStyle: TextStyle(
                          color: gray,
                          fontSize: 12.0
                        ),
                        enabled: true,
                        onTap: () {
                          // This could open a detailed view or edit screen
                        },
                        onLongPress: () {
                        },
                      )
                    );
                },
              );
            },
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to add a new time entry
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTimeEntryScreen()),
          );
        },
        tooltip: "Add Time Entry",
        child: Icon(Icons.add)
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: swamp
              ),
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Time Tracker App",
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                  textAlign: TextAlign.center,
                )
              )
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Projects'),
              onTap: () {
                // Navigator.pop(context); // Close the drawer
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => UserProfileScreen(
                //         currentUserId: currentUserId,
                //       )),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Tasks'),
              onTap: () {
                // Navigator.pop(context); // Close the drawer
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => UserProfileScreen(
                //         currentUserId: currentUserId,
                //       )),
                // );
              },
            ),
          ]
        )
      )
    );
  }
}

    
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:localstorage/localstorage.dart";


import "providers/project_task_provider.dart";

import "constants/colors.dart";

import "screens/home_screen.dart";


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(MyApp(localStorage: localStorage));

}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;
 
  const MyApp({super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(localStorage),
      child: MaterialApp(
        title: "Time Tracker",
        theme: ThemeData(
          primaryColor: swamp,
          hintColor: bog,
          scaffoldBackgroundColor: white,
          appBarTheme: AppBarTheme(
            backgroundColor: swamp,
            titleTextStyle: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            iconTheme: const IconThemeData(color: white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: swamp,
              foregroundColor: white,
              textStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: swamp,
            foregroundColor: white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: const OutlineInputBorder(),
            outlineBorder: const BorderSide(color: bog),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: bog),
            ),
            labelStyle: TextStyle(color: black),
            hintStyle: TextStyle(color: gray),
          ),
          cardTheme: CardTheme(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
          ),
        ),
        home: HomeScreen(), // Set LoginPage as the initial screen
      ),
    );
  }
}

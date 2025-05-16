import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:localstorage/localstorage.dart";

import "package:google_fonts/google_fonts.dart";

import "providers/project_task_provider.dart";
import "consts.dart";

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
          // textTheme: TextStyleTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(swamp)).copyWith(secondary: bog),
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
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: bog),
            ),
            labelStyle: TextStyle(color: Colors.black87),
            hintStyle: TextStyle(color: Colors.grey),
          ),
          cardTheme: CardTheme(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        // home: const HomePage(currentUserId: currentUserId), // Set LoginPage as the initial screen
        home: HomeScreen(), // Set LoginPage as the initial screen
        routes: {
          "/home": (context) => HomeScreen(),
          // "/postQuest": (context) => const PostQuestScreen(currentUserId: currentUserId),
          // "/questDetails": (context) => const QuestDetailsPage(questId: 0, currentUserId: "A23-36640",),
          // "/login": (context) => const LoginPage(),
          // "/register": (context) => const RegistrationPage(), // Add the registration route
        },
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final double strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/courses_provider.dart';
import 'repository/courses_mock_repository.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoursesProvider(repository: CoursesMockRepository()),
      child: MaterialApp(
        home: CourseListScreen(),
      ),
    );
  }
}

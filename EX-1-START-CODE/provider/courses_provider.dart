import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repository/courses_repository.dart';


class CoursesProvider extends ChangeNotifier {
  final CoursesRepository repository;

  CoursesProvider({required this.repository});
  
  List<Course> get courses => repository.getCourses();

  Course getCourseFor(String courseId){
    return repository.getCourses().firstWhere((course) => course.name == courseId);
  }

  void addScore(String courseId, CourseScore score) {
    // Retrieve the course by courseId
    final course = repository.getCourses().firstWhere((course) => course.name == courseId);

    // Add the score to the course
    course.scores.add(score);

    // Notify listeners to update the UI
    notifyListeners();
  }
}

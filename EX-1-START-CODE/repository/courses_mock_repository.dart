import 'package:w6/W6-Practice_part1/EX-1-START-CODE/models/course.dart';
import 'courses_repository.dart';

class CoursesMockRepository implements CoursesRepository{
  final List<Course> _courses = [
    Course(name: 'Flutter'),
    Course(name: 'Dart'),
    Course(name: 'Java'),
  ];
  @override
  List<Course> getCourses() {
    return _courses;
  }
  @override
  void addScore(Course course, CourseScore score) {
    Course course = _courses.firstWhere((course) => course.name == course.name);
    course.addScore(score);
  }
}
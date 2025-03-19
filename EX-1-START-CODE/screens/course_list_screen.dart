import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../provider/courses_provider.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatelessWidget {
  CourseListScreen({super.key});

  void _editCourse(BuildContext context, Course course) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => CourseScreen(courseId: course.name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CoursesProvider>(context);
    final allCourses = courseProvider.courses;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: allCourses.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: Key(allCourses[index].name),
          child: CourseTile(
            course: allCourses[index],
            onEdit: _editCourse,
          ),
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(BuildContext, Course) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average: $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          onTap: () => onEdit(context, course),
          title: Text(course.name),
        ),
      ),
    );
  }
}

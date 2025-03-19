import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../provider/courses_provider.dart';
import 'course_score_form.dart';

const Color mainColor = Colors.blue;

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CoursesProvider>(context);
    final course = courseProvider.getCourseFor(courseId);

    void _addScore(BuildContext context) async {
      final newScore = await Navigator.of(context).push<CourseScore>(
        MaterialPageRoute(builder: (ctx) => CourseScoreForm()),
      );

      if (newScore != null) {
        courseProvider.addScore(courseId, newScore);
      }
    }



    Color scoreColor(double score) {
      return score > 50 ? Colors.green : Colors.orange;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => _addScore(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: course.scores.isEmpty
          ? const Center(child: Text('No Scores added yet.'))
          : ListView.builder(
              itemCount: course.scores.length,
              itemBuilder: (ctx, index) => ListTile(
                title: Text(course.scores[index].studentName),
                trailing: Text(
                  course.scores[index].studentScore.toString(),
                  style: TextStyle(
                    color: scoreColor(course.scores[index].studentScore),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
    );
  }
}

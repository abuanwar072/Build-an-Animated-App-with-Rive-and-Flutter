import 'package:flutter/material.dart';

import '../../models/course.dart';
import 'components/course_card.dart';
import 'components/secondary_course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Courses",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...courses
                        .map((course) => Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CourseCard(course: course),
                            ))
                        .toList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Recent",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ...recentCourses.map(
                (course) => Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: SecondaryCourseCard(course: course),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/course.dart';

class SecondaryCourseCard extends StatelessWidget {
  const SecondaryCourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: course.bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Text(
                  "Watch video - 15 mins",
                  style: TextStyle(color: Colors.white60, fontSize: 16),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(course.iconSrc)
        ],
      ),
    );
  }
}

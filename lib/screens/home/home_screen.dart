import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Courses",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            height: 300,
            width: 260,
            decoration: BoxDecoration(
              color: Color(0xFF7553F6),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, right: 8),
                    child: Column(
                      children: [
                        Text(
                          "Animations in SwiftUI",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 8),
                          child: Text(
                            "Build and animate an iOS app from scratch",
                            style: TextStyle(
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        Text(
                          "61 SECTIONS - 11 HOURS",
                          style: TextStyle(
                            color: Colors.white38,
                          ),
                        ),
                        Spacer(),
                        // CircleAvatar(
                        //   backgroundImage: DecorationImage(),
                        // )
                      ],
                    ),
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/ios.svg",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

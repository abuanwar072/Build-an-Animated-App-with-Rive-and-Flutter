import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';

import '../model/menu.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int selctedTab = 0;
  bool isOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;

  late SMIBool isMenuOpenInput;
  late SMIBool chat;
  late SMIBool search;
  late SMIBool timer;
  late SMIBool bell;
  late SMIBool user;

  SMIBool getRiveInput(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);

    return controller.findInput<bool>("active") as SMIBool;
  }

  void chnageState(SMIBool input) {
    input.change(true);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        input.change(false);
      },
    );
  }

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            isMenuOpenInput.value = !isMenuOpenInput.value;
          },
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: RiveAnimation.asset(
              "assets/RiveAssets/menu_button.riv",
              onInit: (artboard) {
                final controller = StateMachineController.fromArtboard(
                    artboard, "State Machine");

                artboard.addController(controller!);

                isMenuOpenInput =
                    controller.findInput<bool>("isOpen") as SMIBool;
                isMenuOpenInput.value = true;
              },
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(8),
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SvgPicture.asset("assets/icons/User.svg"),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: 288,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF17203A),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    "Abu Anwar",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "YouTuber",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "Browse".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                ),
                ...sidebarMenus
                    .map(
                      (menu) => Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 24),
                            child: Divider(color: Colors.white24, height: 1),
                          ),
                          ListTile(
                            onTap: () {
                              menu.rive.status!.change(true);
                              Future.delayed(
                                const Duration(seconds: 2),
                                () {
                                  menu.rive.status!.change(false);
                                },
                              );
                            },
                            leading: SizedBox(
                              height: 36,
                              width: 36,
                              child: RiveAnimation.asset(
                                menu.rive.src,
                                artboard: menu.rive.artboard,
                                onInit: (artboard) {
                                  menu.rive.status = getRiveInput(artboard,
                                      stateMachineName:
                                          menu.rive.stateMachineName);
                                },
                              ),
                            ),
                            title: Text(
                              menu.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: backgroundColor2.withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavItems.length,
                (index) {
                  Menu navBar = bottomNavItems[index];
                  return GestureDetector(
                    onTap: () {
                      chnageState(navBar.rive.status!);
                      updateSelectedBtmNav(navBar);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(isActive: selectedBottonNav == navBar),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity: selctedTab == 0 ? 1 : 0.5,
                            child: RiveAnimation.asset(
                              navBar.rive.src,
                              artboard: navBar.rive.artboard,
                              onInit: (artboard) {
                                navBar.rive.status = getRiveInput(artboard,
                                    stateMachineName:
                                        navBar.rive.stateMachineName);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 2),
      duration: const Duration(milliseconds: 200),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          )),
    );
  }
}

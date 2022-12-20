import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/home/home_screen.dart';

import '../../model/menu.dart';
import 'components/btm_nav_item.dart';
import 'components/info_card.dart';
import 'components/side_menu.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  int selctedTab = 0;
  bool isSideBarOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

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

  static Matrix4 _pmat(num pv) {
    return new Matrix4(
      1.0, 0.0, 0.0, 0.0, //
      0.0, 1.0, 0.0, 0.0, //
      0.0, 0.0, 1.0, pv * 0.001, //
      0.0, 0.0, 0.0, 1.0,
    );
  }

  Matrix4 perspective = _pmat(1.0);

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(
            () {
              setState(() {});
            },
          );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor2,
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 0 : -288,
            top: 0,
            child: SafeArea(
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
                      const InfoCard(
                        name: "Abu Anwar",
                        bio: "YouTuber",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, top: 32, bottom: 16),
                        child: Text(
                          "Browse".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white70),
                        ),
                      ),
                      ...sidebarMenus
                          .map((menu) => SideMenu(
                                menu: menu,
                                selectedMenu: selectedSideMenu,
                                press: () {
                                  chnageState(menu.rive.status!);
                                  setState(() {
                                    selectedSideMenu = menu;
                                  });
                                },
                                riveOnInit: (artboard) {
                                  menu.rive.status = getRiveInput(artboard,
                                      stateMachineName:
                                          menu.rive.stateMachineName);
                                },
                              ))
                          .toList(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, top: 40, bottom: 16),
                        child: Text(
                          "History".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white70),
                        ),
                      ),
                      ...sidebarMenus2
                          .map((menu) => SideMenu(
                                menu: menu,
                                selectedMenu: selectedSideMenu,
                                press: () {
                                  chnageState(menu.rive.status!);
                                  setState(() {
                                    selectedSideMenu = menu;
                                  });
                                },
                                riveOnInit: (artboard) {
                                  menu.rive.status = getRiveInput(artboard,
                                      stateMachineName:
                                          menu.rive.stateMachineName);
                                },
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: perspective.scaled(1.0, 1.0, 1.0)
              ..rotateX(0)
              ..rotateY(1 * animation.value - 30 * (animation.value) * pi / 180)
              ..rotateZ(0.0),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scalAnimation.value,
                child: const ClipRRect(
                  child: HomePage(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 220 : 0,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  isMenuOpenInput.value = !isMenuOpenInput.value;

                  if (_animationController.value == 0) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }

                  setState(() {
                    isSideBarOpen = !isSideBarOpen;
                  });
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
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
                    return BtmNavItem(
                      navBar: navBar,
                      press: () {
                        chnageState(navBar.rive.status!);
                        updateSelectedBtmNav(navBar);
                      },
                      riveOnInit: (artboard) {
                        navBar.rive.status = getRiveInput(artboard,
                            stateMachineName: navBar.rive.stateMachineName);
                      },
                      selectedNav: selectedBottonNav,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

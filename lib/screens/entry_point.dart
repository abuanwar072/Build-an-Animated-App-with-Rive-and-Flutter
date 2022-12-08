import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int selctedTab = 0;
  bool isOpen = false;

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

  void updateTabIndex(int index) {
    if (selctedTab != index) {
      setState(() {
        selctedTab = index;
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
            padding: EdgeInsets.all(8),
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
      body: HomePage(),
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
              GestureDetector(
                onTap: () {
                  chnageState(chat);
                  updateTabIndex(0);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: selctedTab == 0),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selctedTab == 0 ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          "assets/RiveAssets/icons.riv",
                          artboard: "CHAT",
                          onInit: (artboard) {
                            chat = getRiveInput(artboard,
                                stateMachineName: "CHAT_Interactivity");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  chnageState(search);
                  updateTabIndex(1);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: selctedTab == 1),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selctedTab == 1 ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          "assets/RiveAssets/icons.riv",
                          artboard: "SEARCH",
                          onInit: (artboard) {
                            search = getRiveInput(artboard,
                                stateMachineName: "SEARCH_Interactivity");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  chnageState(timer);
                  updateTabIndex(2);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: selctedTab == 2),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selctedTab == 2 ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          "assets/RiveAssets/icons.riv",
                          artboard: "TIMER",
                          onInit: (artboard) {
                            timer = getRiveInput(artboard,
                                stateMachineName: "TIMER_Interactivity");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  chnageState(bell);
                  updateTabIndex(3);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: selctedTab == 3),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selctedTab == 3 ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          "assets/RiveAssets/icons.riv",
                          artboard: "BELL",
                          onInit: (artboard) {
                            bell = getRiveInput(artboard,
                                stateMachineName: "BELL_Interactivity");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  chnageState(user);
                  updateTabIndex(4);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: selctedTab == 4),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selctedTab == 4 ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          "assets/RiveAssets/icons.riv",
                          artboard: "USER",
                          onInit: (artboard) {
                            user = getRiveInput(artboard,
                                stateMachineName: "USER_Interactivity");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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

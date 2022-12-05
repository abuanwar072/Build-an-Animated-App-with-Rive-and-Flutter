import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
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
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  chnageState(chat);
                },
                child: SizedBox(
                  height: 36,
                  width: 36,
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
              GestureDetector(
                onTap: () {
                  chnageState(search);
                },
                child: SizedBox(
                  height: 36,
                  width: 36,
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
              GestureDetector(
                onTap: () {
                  chnageState(timer);
                },
                child: SizedBox(
                  height: 36,
                  width: 36,
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
              GestureDetector(
                onTap: () {
                  chnageState(bell);
                },
                child: SizedBox(
                  height: 36,
                  width: 36,
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
              GestureDetector(
                onTap: () {
                  chnageState(user);
                },
                child: SizedBox(
                  height: 36,
                  width: 36,
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
      ),
    );
  }
}

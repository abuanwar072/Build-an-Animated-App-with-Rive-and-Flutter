import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/email.svg"),
                    ),
                  ),
                ),
              ),
              const Text(
                "Password",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/password.svg"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // confetti.fire();
                    setState(() {
                      isShowConfetti = true;
                      isShowLoading = true;
                    });
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        if (_formKey.currentState!.validate()) {
                          success.fire();
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              setState(() {
                                isShowLoading = false;
                              });
                              confetti.fire();
                              // Navigate & hide confetti
                            },
                          );
                        } else {
                          error.fire();
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              setState(() {
                                isShowLoading = false;
                              });
                              reset.fire();
                            },
                          );
                        }
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF77D8E),
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      )),
                  icon: const Icon(
                    CupertinoIcons.arrow_right,
                    color: Color(0xFFFE0037),
                  ),
                  label: const Text("Sign In"),
                ),
              ),
            ],
          ),
        ),
        isShowLoading
            ? Positioned.fill(
                child: Column(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: RiveAnimation.asset(
                        'assets/RiveAssets/check.riv',
                        fit: BoxFit.cover,
                        onInit: _onCheckRiveInit,
                      ),
                    ),
                    const Spacer(flex: 2)
                  ],
                ),
              )
            : const SizedBox(),
        isShowConfetti
            ? Positioned.fill(
                child: Column(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Transform.scale(
                        scale: 6,
                        child: RiveAnimation.asset(
                          "assets/RiveAssets/confetti.riv",
                          onInit: _onConfettiRiveInit,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

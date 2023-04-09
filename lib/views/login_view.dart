import 'package:flutter/material.dart';
import 'package:noteapp/components/login_button.dart';
import '../components/data_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bga.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  height: 200,
                  width: 250,
                  child: Image.asset('assets/images/TerpTally.png'),
                ),
                //large scale logo text saying Terptally
                const SizedBox(height: 50),
                const Text(
                  'TerpTally',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 300),
                const LoginButton(),
                const SizedBox(height: 70),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'A bitcamp 2023 project',
                      textStyle: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

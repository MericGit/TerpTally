import 'package:flutter/material.dart';
import 'package:noteapp/components/login_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff6987C9),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
                // logo
                SizedBox(
                    height: 200,
                    width: 250,
                    child: Image.asset('assets/images/TerpTally.png')),
                const SizedBox(height: 400),
                const LoginButton(),
                const SizedBox(height: 70),
                const Text(
                  "A bitcamp 2023 project",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

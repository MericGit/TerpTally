import 'package:flutter/material.dart';
import 'package:noteapp/components/login_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 227, 157, 157),
        body: SafeArea(
          child: Center(
            child: Column(
              children: const [
                SizedBox(height: 50),
                // logo
                Icon(
                  Icons.lock,
                  size: 200,
                ),
                SizedBox(height: 400),
                LoginButton(),

                //Login with Google text
                //Firebase uath button

                //Copyright spec info
              ],
            ),
          ),
        ));
  }
}

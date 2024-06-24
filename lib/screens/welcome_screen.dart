import 'package:firstapp/screens/signin_screen.dart';
import 'package:firstapp/screens/signup_screen.dart';
import 'package:firstapp/theme/theme.dart';
import 'package:firstapp/widgets/welcome_button.dart';
import 'package:firstapp/widgets/welcomescreenscaffold.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.fromLTRB(40.0, 100.0, 40.0, 0),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: 'Welcome to PetPal\n',
                            style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.w600,
                            )),
                        TextSpan(
                            text:
                                "\nThe ultimate app for managing your pet's health, nutrition, and happiness effortlessly.",
                            style: TextStyle(
                              fontSize: 20,
                              // height: 0,
                            ))
                      ],
                    ),
                  ),
                ),
              )),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: const SignUpScreen(),
                      color: Colors.white,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

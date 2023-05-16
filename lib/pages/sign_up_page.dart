import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/widgets/button_widget.dart';
import 'package:news_app/widgets/input_widget.dart';
import 'package:news_app/widgets/link_text_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'My News\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Have a nice day at work',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  InputWidget(
                    controller: emailController,
                    label: 'Email',
                    iconData: Icons.email,
                    isAutoFocus: true,
                  ),
                  InputWidget(
                    controller: usernameController,
                    label: 'Username',
                    iconData: Icons.person,
                  ),
                  InputWidget(
                    controller: passwordController,
                    label: 'Password',
                    iconData: Icons.lock,
                    isObscure: true,
                  ),
                  InputWidget(
                    controller: passwordConfirmController,
                    label: 'Confirm Password',
                    iconData: Icons.lock,
                    isObscure: true,
                  ),
                  LinkTextWidget(
                    onPressed: () {
                      context.pop();
                    },
                    intro: 'Have an account? ',
                    link: 'Back to login',
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8, top: 32),
                    child: Row(
                      children: [
                        ButtonWidget(
                          onPressed: () async {
                            context.pop();
                          },
                          text: 'Sign up',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

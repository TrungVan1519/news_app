import 'package:flutter/material.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/sign_up_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/widgets/button_widget.dart';
import 'package:news_app/widgets/input_widget.dart';
import 'package:news_app/widgets/text_link_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                    controller: usernameController,
                    label: 'Username',
                    iconData: Icons.person,
                    isAutoFocus: true,
                  ),
                  InputWidget(
                    controller: passwordController,
                    label: 'Password',
                    iconData: Icons.lock,
                    isObscure: true,
                  ),
                  TextLinkWidget(
                    onPressed: () {
                      context.push(const SignUpPage());
                    },
                    intro: 'Have not an account? ',
                    link: 'Create a new one',
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 8, top: 32),
                    child: Row(
                      children: [
                        ButtonWidget(
                          onPressed: () async {
                            context.push(const HomePage());
                          },
                          text: 'Login',
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

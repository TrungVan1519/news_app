// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_app/models/response/user.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/utils/http_utils.dart';
import 'package:news_app/widgets/button_widget.dart';
import 'package:news_app/widgets/input_widget.dart';
import 'package:news_app/widgets/text_link_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
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
                    controller: nameController,
                    label: 'Name',
                    iconData: Icons.text_fields,
                    isAutoFocus: true,
                  ),
                  InputWidget(
                    controller: emailController,
                    label: 'Email',
                    iconData: Icons.email,
                  ),
                  InputWidget(
                    controller: phoneController,
                    label: 'Phone',
                    iconData: Icons.phone,
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
                  TextLinkWidget(
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
                            if (passwordController.text !=
                                passwordConfirmController.text) {
                              context.showSnackBar('Match your password');
                            } else {
                              try {
                                final response = await HttpUtils.signup(
                                  User(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                );

                                if (response.status!.code! == 1000) {
                                  context.pop(true);
                                } else {
                                  context.showSnackBar('Fail to sign up');
                                }
                              } catch (e) {
                                context.showSnackBar(e.toString());
                              }
                            }
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

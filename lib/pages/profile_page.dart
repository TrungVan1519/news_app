import 'package:flutter/material.dart';
import 'package:news_app/pages/booked_article_list_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/widgets/button_widget.dart';
import 'package:news_app/widgets/input_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  double corner = 100;

  @override
  void dispose() {
    super.dispose();
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
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: corner,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(corner),
                      child: Image.network(
                        'https://avatars.githubusercontent.com/u/49634155?v=4',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 64),
                    child: const Text(
                      'Email.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: false,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              builder: (_) {
                                return Container(
                                  height: context.height / 2,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 32,
                                  ),
                                  child: Column(
                                    children: [
                                      InputWidget(
                                        controller: passwordController,
                                        label: 'Password',
                                        iconData: Icons.lock,
                                        isAutoFocus: true,
                                        isObscure: true,
                                      ),
                                      InputWidget(
                                        controller: passwordConfirmController,
                                        label: 'Confirm Password',
                                        iconData: Icons.lock,
                                        isObscure: true,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                right: 5,
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  passwordController.clear();
                                                  passwordConfirmController
                                                      .clear();
                                                  context.pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                  ),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () async {},
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                  ),
                                                  child: Text(
                                                    'Update',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Card(
                            margin: EdgeInsets.only(right: 8),
                            elevation: 8,
                            child: SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.key),
                                  Text(
                                    'Change password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.push(const BookedArticleListPage());
                          },
                          child: const Card(
                            margin: EdgeInsets.only(left: 8),
                            elevation: 8,
                            child: SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.list),
                                  Text(
                                    'My booked articles',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Row(
                      children: [
                        ButtonWidget(
                          onPressed: () async {
                            context.popUntilFirst();
                          },
                          text: 'Logout',
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

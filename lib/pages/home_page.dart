import 'package:flutter/material.dart';
import 'package:news_app/pages/article_page.dart';
import 'package:news_app/pages/booked_article_page.dart';
import 'package:news_app/pages/profile_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/widgets/bottom_app_bar_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var i = 0;
  final pages = const [ArticlePage(), BookedArticlePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: i, children: pages),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomAppBarItemWidget(
              icon: Icon(
                Icons.article,
                color: i == 0 ? Colors.blue : Colors.black,
              ),
              index: 0,
              onPressed: () {
                i = 0;
                setState(() {});
              },
            ),
            const SizedBox(width: 8),
            BottomAppBarItemWidget(
              icon: Icon(
                Icons.list,
                color: i == 1 ? Colors.blue : Colors.black,
              ),
              index: 1,
              onPressed: () {
                i = 1;
                setState(() {});
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const ProfilePage());
        },
        child: const Icon(Icons.account_circle),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

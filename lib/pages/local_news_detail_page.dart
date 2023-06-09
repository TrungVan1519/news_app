import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/models/local_news/local_news.dart';
import 'package:news_app/models/response/user.dart';
import 'package:news_app/utils/constant.dart';
import 'package:news_app/utils/http_utils.dart';
import 'package:news_app/utils/injections.dart';
import 'package:news_app/widgets/loading_image_widget.dart';
import 'package:news_app/widgets/text_content_widget.dart';
import 'package:news_app/widgets/text_subtitle_widget.dart';
import 'package:news_app/widgets/text_title_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNewsDetailPage extends StatefulWidget {
  const LocalNewsDetailPage({super.key, this.news});

  final LocalNews? news;

  @override
  State<LocalNewsDetailPage> createState() => _LocalNewsDetailPageState();
}

class _LocalNewsDetailPageState extends State<LocalNewsDetailPage> {
  bool isLiked = false;
  late User user;

  checkIfIsLiked() async {
    final response = await HttpUtils.getAllFavorite(user);

    isLiked = response.data!.contains(widget.news!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    user = User.fromJson(
      jsonDecode(getIt<SharedPreferences>().getString(Constants.keyUser)!),
    );
    checkIfIsLiked();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      TextTitleWidget(text: widget.news?.title),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextSubtitleWidget(text: widget.news?.author),
                            TextSubtitleWidget(
                              text: widget.news?.createTime
                                  .toString()
                                  .split(' ')[0],
                            ),
                          ],
                        ),
                      ),
                      LoadingImageWidget(urlToImage: widget.news?.thumbnail),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: TextContentWidget(text: widget.news?.content),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (!isLiked) {
            HttpUtils.addToFavorite(user, widget.news!);
            isLiked = true;
            setState(() {});
          } else {
            HttpUtils.removeFromFavorite(user, widget.news!);
            isLiked = false;
            setState(() {});
          }
        },
        child: Icon(
          Icons.favorite,
          color: isLiked ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}

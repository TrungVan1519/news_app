import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/models/local_news/local_news.dart';
import 'package:news_app/models/response/user.dart';
import 'package:news_app/pages/local_news_detail_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/utils/constant.dart';
import 'package:news_app/utils/http_utils.dart';
import 'package:news_app/utils/injections.dart';
import 'package:news_app/widgets/loading_image_widget.dart';
import 'package:news_app/widgets/text_subtitle_widget.dart';
import 'package:news_app/widgets/text_title_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedArticleListPage extends StatefulWidget {
  const BookedArticleListPage({super.key});

  @override
  State<BookedArticleListPage> createState() => _BookedArticleListPageState();
}

class _BookedArticleListPageState extends State<BookedArticleListPage> {
  List<LocalNews> newsList = [];
  bool isLoading = false;

  init(int categoryId) async {
    isLoading = true;
    setState(() {});

    final response = await HttpUtils.getAllFavorite(
      User.fromJson(
          jsonDecode(getIt<SharedPreferences>().getString(Constants.keyUser)!)),
    );
    newsList.clear();
    newsList.addAll(response.data ?? []);

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init(Category.General.index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : newsList.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (_, i) {
                            final news = newsList[i];

                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: SizedBox(
                                child: ListTile(
                                  onTap: () {
                                    context.push(
                                      LocalNewsDetailPage(news: news),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.all(8),
                                  title: TextTitleWidget(text: news.title),
                                  subtitle: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextSubtitleWidget(
                                              text: news.author,
                                            ),
                                            TextSubtitleWidget(
                                              text: news.createTime
                                                  .toString()
                                                  .split(' ')[0],
                                            )
                                          ],
                                        ),
                                      ),
                                      LoadingImageWidget(
                                        urlToImage: news.thumbnail,
                                        alt: 'No image available',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: newsList.length,
                        )
                      : const Center(
                          child: TextSubtitleWidget(
                            text: 'Favorite news list is not available',
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

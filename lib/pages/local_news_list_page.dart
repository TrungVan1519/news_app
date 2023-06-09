import 'package:flutter/material.dart';
import 'package:news_app/models/local_news/local_news.dart';
import 'package:news_app/pages/local_news_detail_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/utils/constant.dart';
import 'package:news_app/utils/http_utils.dart';
import 'package:news_app/widgets/loading_image_widget.dart';
import 'package:news_app/widgets/text_subtitle_widget.dart';
import 'package:news_app/widgets/text_title_widget.dart';

class LocalNewsListPage extends StatefulWidget {
  const LocalNewsListPage({super.key, required this.isDomestic});

  final bool isDomestic;

  @override
  State<LocalNewsListPage> createState() => _LocalNewsListPageState();
}

class _LocalNewsListPageState extends State<LocalNewsListPage> {
  List<LocalNews> newsList = [];
  bool isLoading = false;
  Category selectedCategory = Category.General;

  init(int categoryId) async {
    isLoading = true;
    setState(() {});

    newsList.clear();
    newsList.addAll(
      await HttpUtils.getAllLocalNews(widget.isDomestic, categoryId),
    );

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
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  final category = Category.values[i];

                  return GestureDetector(
                    onTap: () async {
                      selectedCategory = category;
                      setState(() {});

                      await init(selectedCategory.index + 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: category == selectedCategory
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        category.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: Category.values.length,
              ),
            ),
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
                            text: 'International news list is not available',
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

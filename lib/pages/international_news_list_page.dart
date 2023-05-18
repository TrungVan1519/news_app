import 'package:flutter/material.dart';
import 'package:news_app/models/international_news/international_response.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/utils/constant.dart';
import 'package:news_app/utils/http_utils.dart';
import 'package:news_app/widgets/loading_image_widget.dart';
import 'package:news_app/widgets/text_subtitle_widget.dart';
import 'package:news_app/widgets/text_title_widget.dart';

class InternationalNewsListPage extends StatefulWidget {
  const InternationalNewsListPage({super.key});

  @override
  State<InternationalNewsListPage> createState() =>
      _InternationalNewsListPageState();
}

class _InternationalNewsListPageState extends State<InternationalNewsListPage> {
  InternationalResponse? response;
  bool isLoading = false;
  Category selectedCategory = Category.General;

  @override
  void initState() {
    super.initState();
    getAllInternationalNews();
  }

  getAllInternationalNews([String? category]) async {
    isLoading = true;
    setState(() {});

    response = await HttpUtils.getAllInternationalNews(
      category ?? selectedCategory.name,
    );
    isLoading = false;
    setState(() {});
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
                      await getAllInternationalNews(category.name);
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
                  : response != null
                      ? ListView.builder(
                          itemBuilder: (_, i) {
                            final news = response!.articles![i];

                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: SizedBox(
                                child: ListTile(
                                  onTap: () {
                                    context.push(
                                      NewsDetailPage(internationalNews: news),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.all(8),
                                  title: TextTitleWidget(
                                    text: news.title,
                                    alt: news.description,
                                  ),
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
                                              text: news.source?.name,
                                              alt: news.author,
                                            ),
                                            TextSubtitleWidget(
                                              text: news.publishedAt
                                                  ?.split('T')[0],
                                            )
                                          ],
                                        ),
                                      ),
                                      LoadingImageWidget(
                                        urlToImage: news.urlToImage,
                                        alt: news.description,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: response!.articles!.length,
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

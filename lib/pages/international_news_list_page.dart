import 'package:flutter/material.dart';
import 'package:news_app/models/international_news/international_news.dart';
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
  List<InternationalNews> newsList = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  Category selectedCategory = Category.General;
  ScrollController scrollController = ScrollController();
  int page = 1;

  getInternationalNewsList() async {
    final response = await HttpUtils.getAllInternationalNews(
      selectedCategory.name,
      page,
    );
    page++;
    return response?.articles != null ? response!.articles! : [];
  }

  expandInternationalNewsList() async {
    isLoadingMore = true;
    setState(() {});

    newsList.addAll(await getInternationalNewsList());

    isLoadingMore = false;
    setState(() {});
  }

  initInternationalNews() async {
    isLoading = true;
    setState(() {});

    newsList.clear();
    newsList.addAll(await getInternationalNewsList());

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initInternationalNews();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await expandInternationalNewsList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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

                      await initInternationalNews();
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
                          controller: scrollController,
                          itemBuilder: (_, i) {
                            if (i == newsList.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final news = newsList[i];

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
                          itemCount: newsList.length + 1,
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

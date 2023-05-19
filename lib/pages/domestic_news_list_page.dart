import 'package:flutter/material.dart';
import 'package:news_app/models/domestic_news/domestic_news.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/utils/constant.dart';
import 'package:news_app/utils/http_utils.dart';
import 'package:news_app/widgets/loading_image_widget.dart';
import 'package:news_app/widgets/text_subtitle_widget.dart';
import 'package:news_app/widgets/text_title_widget.dart';

class DomesticNewsListPage extends StatefulWidget {
  const DomesticNewsListPage({super.key});

  @override
  State<DomesticNewsListPage> createState() => _DomesticNewsListPageState();
}

class _DomesticNewsListPageState extends State<DomesticNewsListPage> {
  List<DomesticNews> newsList = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  Category selectedCategory = Category.General;
  ScrollController scrollController = ScrollController();
  String? page;

  getDomesticNewsList() async {
    final response = await HttpUtils.getAllDomesticNews(
      selectedCategory.name,
      page,
    );
    page = response?.nextPage;
    return response?.results != null ? response!.results! : [];
  }

  expandDomesticNewsList() async {
    isLoadingMore = true;
    setState(() {});

    newsList.addAll(await getDomesticNewsList());

    isLoadingMore = false;
    setState(() {});
  }

  initDomesticNewsList() async {
    isLoading = true;
    setState(() {});

    newsList.clear();
    newsList.addAll(await getDomesticNewsList());

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initDomesticNewsList();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await expandDomesticNewsList();
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

                      await initDomesticNewsList();
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
                                      NewsDetailPage(domesticNews: news),
                                    );
                                  },
                                  contentPadding: const EdgeInsets.all(8),
                                  title: TextTitleWidget(
                                    text: news.title,
                                    alt: news.keywords?.join(', '),
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
                                              text: news.sourceId,
                                              alt: news.creator?.join(', '),
                                            ),
                                            TextSubtitleWidget(
                                              text: news.pubDate?.split(' ')[0],
                                            ),
                                          ],
                                        ),
                                      ),
                                      LoadingImageWidget(
                                        urlToImage: news.imageUrl,
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
                            text: 'Domestic news list is not available',
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

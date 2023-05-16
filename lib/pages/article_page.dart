import 'package:flutter/material.dart';
import 'package:news_app/models/article_response.dart';
import 'package:news_app/utils/constant.dart';
import 'package:news_app/utils/http_utils.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ArticleResponse? articleResponse;
  bool isLoading = false;
  Header selectedHeader = Header.All;

  @override
  void initState() {
    super.initState();
    getAllNews();
  }

  getAllNews([String? q]) async {
    isLoading = true;
    setState(() {});

    articleResponse = await HttpUtils.getAllNews(q);
    isLoading = false;
    setState(() {});
  }

  getLatestNews() async {
    isLoading = true;
    setState(() {});

    articleResponse = await HttpUtils.getLatestNews();
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
                  final header = Header.values[i];

                  return GestureDetector(
                    onTap: () async {
                      selectedHeader = header;
                      setState(() {});

                      switch (header) {
                        case Header.All:
                          await getAllNews();
                          break;
                        case Header.Latest:
                          await getLatestNews();
                          break;
                        default:
                          await getAllNews(header.name);
                      }
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
                        color: header == selectedHeader
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        header.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: Header.values.length,
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : articleResponse != null
                      ? ListView.builder(
                          itemBuilder: (_, i) {
                            final article = articleResponse!.articles![i];

                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: SizedBox(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8),
                                  title: Text(
                                    article.title ?? article.description ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              article.source?.name ??
                                                  article.author ??
                                                  '',
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(article.publishedAt
                                                    ?.split('T')[0] ??
                                                '')
                                          ],
                                        ),
                                      ),
                                      article.urlToImage != null
                                          ? Image.network(
                                              article.urlToImage!,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (_, child, progress) {
                                                final percentage = progress
                                                            ?.expectedTotalBytes !=
                                                        null
                                                    ? progress!
                                                            .cumulativeBytesLoaded /
                                                        progress
                                                            .expectedTotalBytes!
                                                    : null;
                                                return progress == null
                                                    ? child
                                                    : LinearProgressIndicator(
                                                        value: percentage,
                                                      );
                                              },
                                            )
                                          : Text(article.description ?? ''),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: articleResponse!.articles!.length,
                        )
                      : const Center(child: Text('No articles are available')),
            ),
          ],
        ),
      ),
    );
  }
}

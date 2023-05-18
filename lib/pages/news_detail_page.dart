import 'package:flutter/material.dart';
import 'package:news_app/models/domestic_news/domestic_news.dart';
import 'package:news_app/models/international_news/international_news.dart';
import 'package:news_app/pages/news_original_detail_page.dart';
import 'package:news_app/utils/build_context_ext.dart';
import 'package:news_app/widgets/text_link_widget.dart';
import 'package:news_app/widgets/loading_image_widget.dart';
import 'package:news_app/widgets/text_content_widget.dart';
import 'package:news_app/widgets/text_subtitle_widget.dart';
import 'package:news_app/widgets/text_title_widget.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({
    super.key,
    this.internationalNews,
    this.domesticNews,
  });

  final InternationalNews? internationalNews;
  final DomesticNews? domesticNews;

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  buildDomesticNews() {
    return Column(
      children: [
        TextTitleWidget(
          text: widget.domesticNews?.title,
          alt: widget.domesticNews?.keywords?.join(', '),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSubtitleWidget(
                text: widget.domesticNews?.sourceId,
                alt: widget.domesticNews?.creator?.join(', '),
              ),
              TextSubtitleWidget(
                text: widget.domesticNews?.pubDate?.split(' ')[0],
              ),
            ],
          ),
        ),
        LoadingImageWidget(
          urlToImage: widget.domesticNews?.imageUrl,
          alt: widget.domesticNews?.description,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: TextContentWidget(text: widget.domesticNews?.content),
        ),
        TextLinkWidget(
          onPressed: () {
            context.push(
              NewsOriginalDetailPage(url: widget.domesticNews?.link),
            );
          },
          link: widget.domesticNews?.link,
        ),
      ],
    );
  }

  buildInternationalNews() {
    return Column(
      children: [
        TextTitleWidget(text: widget.internationalNews?.title),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSubtitleWidget(
                text: widget.internationalNews?.source?.name,
                alt: widget.internationalNews?.author,
              ),
              TextSubtitleWidget(
                text: widget.internationalNews?.publishedAt?.split('T')[0],
              ),
            ],
          ),
        ),
        LoadingImageWidget(
          urlToImage: widget.internationalNews?.urlToImage,
          alt: widget.internationalNews?.description,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: TextContentWidget(text: widget.internationalNews?.content),
        ),
        TextLinkWidget(
          onPressed: () {
            context.push(
              NewsOriginalDetailPage(url: widget.internationalNews?.url),
            );
          },
          link: widget.internationalNews?.url,
        ),
      ],
    );
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
                  if (widget.domesticNews != null) buildDomesticNews(),
                  if (widget.internationalNews != null)
                    buildInternationalNews(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/widgets/text_content_widget.dart';

class LoadingImageWidget extends StatefulWidget {
  const LoadingImageWidget({
    super.key,
    this.urlToImage,
    this.alt,
  });

  final String? urlToImage;
  final String? alt;

  @override
  State<LoadingImageWidget> createState() => _LoadingImageWidgetState();
}

class _LoadingImageWidgetState extends State<LoadingImageWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.urlToImage == null
        ? TextContentWidget(text: widget.alt)
        : Image.network(
            widget.urlToImage!.contains('https')
                ? widget.urlToImage!
                : 'https:${widget.urlToImage}',
            fit: BoxFit.fill,
            loadingBuilder: (_, child, progress) {
              final percentage = progress?.expectedTotalBytes != null
                  ? progress!.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!
                  : null;

              return progress == null
                  ? child
                  : LinearProgressIndicator(value: percentage);
            },
          );
  }
}

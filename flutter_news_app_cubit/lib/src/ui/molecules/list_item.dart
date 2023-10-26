import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';

const _imageSize = 120.0;

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.article,
    required this.onTap,
  });

  final Article article;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Image(url: article.urlToImage),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (article.description != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        article.description!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.url,
  });

  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Container(
            width: _imageSize,
            height: _imageSize,
            color: Colors.red,
          )
        : CachedNetworkImage(
            width: _imageSize,
            height: _imageSize,
            imageUrl: url!,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(
              width: _imageSize,
              height: _imageSize,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
  }
}

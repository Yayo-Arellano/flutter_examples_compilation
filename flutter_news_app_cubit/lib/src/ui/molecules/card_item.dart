import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:flutter_news_app_cubit/src/navigation/routes.dart';

class CardItem extends StatelessWidget {
  final Article article;

  const CardItem({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final args = (article: article);
        Navigator.pushNamed(context, Routes.detailsScreen, arguments: args);
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            article.urlToImage == null
                ? Container(color: Colors.red, height: 250)
                : CachedNetworkImage(
                    height: 250,
                    imageUrl: article.urlToImage!,
                    placeholder: (context, url) => const SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    fit: BoxFit.fitHeight,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    article.title,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  if (article.description != null) ...[
                    const SizedBox(height: 8),
                    Text(article.description!, maxLines: 3),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

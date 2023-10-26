import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/localization/locale_keys.g.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            article.urlToImage == null
                ? Container(color: Colors.red, height: 250)
                : CachedNetworkImage(
                    width: 450,
                    imageUrl: article.urlToImage!,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            Text(
              article.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('${article.content}'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => launchUrlString(article.url),
              child: Text(LocaleKeys.view_more.tr()),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

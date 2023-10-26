import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app_cubit/src/bloc/news_cubit.dart';
import 'package:flutter_news_app_cubit/src/localization/locale_keys.g.dart';
import 'package:flutter_news_app_cubit/src/localization/supported_locales.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:flutter_news_app_cubit/src/navigation/routes.dart';
import 'package:flutter_news_app_cubit/src/ui/molecules/card_item.dart';
import 'package:flutter_news_app_cubit/src/ui/molecules/details_widget.dart';
import 'package:flutter_news_app_cubit/src/ui/molecules/list_item.dart';
import 'package:flutter_news_app_cubit/src/ui/molecules/search_widget.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit(locale)..searchNews(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.top_headlines.tr()),
          actions: [
            _LanguagePopUpMenu(),
          ],
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            return Column(
              children: [
                SearchWidget(
                  onChanged: (text) {
                    context
                        .read<NewsCubit>()
                        .searchNews(search: text.length > 3 ? text : null);
                  },
                  onClearPress: context.read<NewsCubit>().clearSearch,
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is NewsSuccessState) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            return switch (constraints.maxWidth) {
                              < 480 => _SmallSize(news: state.news),
                              < 900 => _MediumSize(news: state.news),
                              _ => _BigSize(news: state.news),
                            };
                          },
                        );
                      } else if (state is NewsErrorState) {
                        return Text(state.message);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LanguagePopUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.translate),
      itemBuilder: (context) {
        return supportedLocales.entries.map((it) {
          return PopupMenuItem(
            value: it.key,
            child: Text(it.value),
          );
        }).toList();
      },
      onSelected: (selectedLocale) {
        context.setLocale(selectedLocale);
        context.read<NewsCubit>().setLocale(selectedLocale);
      },
    );
  }
}

class _SmallSize extends StatelessWidget {
  final List<Article> news;

  const _SmallSize({required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (_, int index) => CardItem(article: news[index]),
    );
  }
}

class _MediumSize extends StatelessWidget {
  final List<Article> news;

  const _MediumSize({required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (_, int index) => ListItem(
        article: news[index],
        onTap: () {
          final args = (article: news[index]);
          Navigator.pushNamed(context, Routes.detailsScreen, arguments: args);
        },
      ),
    );
  }
}

class _BigSize extends HookWidget {
  final List<Article> news;

  const _BigSize({required this.news});

  @override
  Widget build(BuildContext context) {
    final currentNew = useState(news.firstOrNull);

    return Row(
      children: [
        SizedBox(
          width: 450,
          child: ListView.builder(
            itemCount: news.length,
            itemBuilder: (_, int index) => ListItem(
              article: news[index],
              onTap: () => currentNew.value = news[index],
            ),
          ),
        ),
        if (currentNew.value != null)
          Expanded(
            child: DetailsWidget(
              article: currentNew.value!,
            ),
          ),
      ],
    );
  }
}

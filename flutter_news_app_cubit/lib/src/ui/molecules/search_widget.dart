import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_news_app_cubit/src/localization/locale_keys.g.dart';

class SearchWidget extends HookWidget {
  const SearchWidget({
    super.key,
    required this.onChanged,
    required this.onClearPress,
  });

  final VoidCallback onClearPress;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final searchTermEmpty = useState(controller.text.isEmpty);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        onChanged: (text) {
          EasyDebounce.debounce(
            'search-news',
            const Duration(milliseconds: 300),
            () => onChanged.call(text),
          );
          searchTermEmpty.value = controller.text.isEmpty;
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: LocaleKeys.search_news.tr(),
          suffixIcon: searchTermEmpty.value
              ? null
              : IconButton(
                  onPressed: () {
                    controller.clear();
                    onClearPress.call();
                  },
                  icon: const Icon(Icons.clear),
                ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

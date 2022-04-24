import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/bloc/navigation_cubit.dart';
import 'package:flutter_currency_converter/src/localization/locale_keys.g.dart';
import 'package:flutter_currency_converter/src/ui/converter_screen.dart';
import 'package:flutter_currency_converter/src/ui/favorites_screen.dart';
import 'package:flutter_currency_converter/src/ui/settings_screen.dart';

class BottomNavItem extends Equatable {
  static final converter = BottomNavItem._(0, LocaleKeys.converter, Icons.money);
  static final favorites = BottomNavItem._(1, LocaleKeys.favorites, Icons.favorite);
  static final settings = BottomNavItem._(2, LocaleKeys.settings, Icons.settings);

  static List<BottomNavItem> get values => [converter, favorites, settings];

  final int index;
  final String localeKey;
  final IconData icon;

  BottomNavItem._(this.index, this.localeKey, this.icon);

  @override
  List<Object> get props => [index, localeKey];
}

class BottomBarWidget extends StatelessWidget {
  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BottomBarWidget(),
    );
  }

  Map<BottomNavItem, WidgetBuilder> get widgetBuilders {
    return {
      BottomNavItem.converter: (context) => ConverterScreen.create(context),
      BottomNavItem.favorites: (context) => FavoritesScreen.create(context),
      BottomNavItem.settings: (context) => SettingsScreen.create(context),
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, BottomNavItem>(
      builder: (context, state) => widgetBuilders[state]!(context),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(this.currentItem);

  final BottomNavItem currentItem;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentItem.index,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => onItemTapped(context, index),
      items: [
        getNavigationBarItem(BottomNavItem.converter),
        getNavigationBarItem(BottomNavItem.favorites),
        getNavigationBarItem(BottomNavItem.settings),
      ],
    );
  }

  BottomNavigationBarItem getNavigationBarItem(BottomNavItem item) {
    return BottomNavigationBarItem(
      label: item.localeKey.tr(),
      icon: Icon(item.icon),
    );
  }

  void onItemTapped(BuildContext context, int index) {
    final item = BottomNavItem.values.firstWhere((it) => it.index == index);
    context.read<NavigationCubit>().onChanged(item);
  }
}

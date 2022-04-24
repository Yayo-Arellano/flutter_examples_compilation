import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/bloc/settings_cubit.dart';
import 'package:flutter_currency_converter/src/localization/supported_locales.dart';
import 'package:flutter_currency_converter/src/localization/codegen_loader.g.dart';
import 'package:flutter_currency_converter/src/provider/db_provider.dart';
import 'package:flutter_currency_converter/src/provider/rest_provider.dart';
import 'package:flutter_currency_converter/src/repository/currency_repository.dart';
import 'package:flutter_currency_converter/src/repository/implementation/currency_repository.dart';
import 'package:flutter_currency_converter/src/ui/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final restProvider = RestProvider();
  final dbProvider = await DbProvider().init();

  final currencyRepo = CurrencyRepository(restProvider, dbProvider);
  final settingsCubit = await SettingsCubit().init();

  runApp(
    RepositoryProvider<CurrencyRepositoryBase>(
      create: (_) => currencyRepo,
      child: BlocProvider(
        create: (_) => settingsCubit,
        child: EasyLocalization(
          supportedLocales: supportedLocales.keys.toList(),
          // When we pass assetLoader: CodegenLoader() path is not needed.
          path: 'xxx',
          fallbackLocale: english,
          child: MyApp(),
          assetLoader: CodegenLoader(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Currency Convertor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomBarWidget.create(context),
    );
  }
}

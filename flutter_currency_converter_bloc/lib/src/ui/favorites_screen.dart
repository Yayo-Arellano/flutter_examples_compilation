import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/bloc/navigation_cubit.dart';
import 'package:flutter_currency_converter/src/bloc/favorites_cubit.dart';
import 'package:flutter_currency_converter/src/localization/locale_keys.g.dart';
import 'package:flutter_currency_converter/src/model/currency.dart';
import 'package:flutter_currency_converter/src/repository/currency_repository.dart';
import 'package:flutter_currency_converter/src/ui/bottom_bar.dart';

class FavoritesScreen extends StatelessWidget {
  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit(context.read<CurrencyRepositoryBase>()),
      child: FavoritesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.favorites.tr())),
      bottomNavigationBar: BottomNavBar(context.watch<NavigationCubit>().state),
      body: BlocListener<FavoritesCubit, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteWarningState) {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<FavoritesCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteReadyState) {
              return Column(
                children: [
                  _SearchInputWidget(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.currencies.length + 1,
                      itemBuilder: (context, int index) {
                        if (index == 0) {
                          return SelectedCurrencyRow(state.selected);
                        } else {
                          return CurrencyRow(state.currencies[index - 1]);
                        }
                      },
                    ),
                  )
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class CurrencyRow extends StatelessWidget {
  final Currency currency;

  const CurrencyRow(this.currency);

  Future<void> setEnabled(BuildContext context, Currency currency) =>
      context.read<FavoritesCubit>().setEnabled(currency.key, !currency.isEnabled);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async => setEnabled(context, currency),
        title: Text(currency.key),
        subtitle: Text('key_${currency.key}'.tr()),
        leading: Image.asset('assets/flags/${currency.key}.png'),
        trailing: Checkbox(
          key: Key(currency.key),
          value: currency.isEnabled,
          onChanged: (bool? value) async => setEnabled(context, currency),
        ),
      ),
    );
  }
}

class SelectedCurrencyRow extends StatelessWidget {
  final Currency currency;

  const SelectedCurrencyRow(this.currency);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${currency.key} ${LocaleKeys.selected_currency.tr()}'),
        subtitle: Text('key_${currency.key}'.tr()),
        leading: Image.asset('assets/flags/${currency.key}.png'),
      ),
    );
  }
}

class _SearchInputWidget extends StatefulWidget {
  @override
  _SearchInputWidgetState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<_SearchInputWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      context.read<FavoritesCubit>().filterCurrencies(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: LocaleKeys.search_currency.tr(),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () => _controller.clear(),
                  icon: const Icon(Icons.clear),
                ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

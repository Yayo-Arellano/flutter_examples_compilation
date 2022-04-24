import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_currency_converter/src/extensions/list_extension.dart';
import 'package:flutter_currency_converter/src/extensions/string_extension.dart';
import 'package:flutter_currency_converter/src/model/currency.dart';
import 'package:flutter_currency_converter/src/repository/currency_repository.dart';

class FavoritesCubit extends Cubit<FavoriteState> {
  final CurrencyRepositoryBase _repository;

  late final StreamSubscription subscription;

  late Currency _selected;

  List<Currency> _currencies = [];

  String filter = '';

  FavoritesCubit(this._repository) : super(FavoriteLoadingState()) {
    _init();
  }

  Future<void> _init() async {
    subscription = _repository.getCurrencies().listen((it) async {
      if (it.isNotEmpty) {
        _currencies = it;
        _selected = await _repository.getSelectedCurrency();
        _updateState();
      }
    });
  }

  void filterCurrencies(String filter) {
    this.filter = filter;
    _updateState();
  }

  void _updateState() {
    if (filter.isEmpty) {
      emit(FavoriteReadyState(_currencies, _selected));
    } else {
      final result = _currencies.where((it) {
        return it.key.containsIgnoreCase(filter) || 'key_${it.key}'.tr().containsIgnoreCase(filter);
      }).toList();
      emit(FavoriteReadyState(result, _selected));
    }
  }

  Future<void> setEnabled(String key, bool isEnabled) async {
    if (_selected.key == key) {
      setWarning('Cannot disable selected currency');
    } else if (!isEnabled && _totalEnabledCurrencies <= 2) {
      setWarning('Cannot disable all currencies');
    } else {
      if (isEnabled) {
        await _repository.enableCurrency(key, 9999);
      } else {
        await _repository.disableCurrency(key);
      }
      final edited = await _repository.getCurrency(key);
      _currencies = List.from(_currencies)..replaceWhere((it) => it.key == key, edited);
      _updateState();
    }
  }

  void setWarning(String message) async {
    emit(FavoriteWarningState(message));
    await Future.delayed(Duration(milliseconds: 100));
    _updateState();
  }

  int get _totalEnabledCurrencies => _currencies.where((it) => it.isEnabled).length;

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}

class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteReadyState extends FavoriteState {
  final List<Currency> currencies;
  final Currency selected;

  FavoriteReadyState(this.currencies, this.selected);

  @override
  List<Object> get props => [currencies];
}

class FavoriteWarningState extends FavoriteState {
  final String message;

  FavoriteWarningState(this.message);

  @override
  List<Object> get props => [message];
}

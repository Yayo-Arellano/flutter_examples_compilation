import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_currency_converter/src/bloc/favorites_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_currency_repository.dart';

void main() {
  late MockCurrencyRepository currencyRepository;

  setUp(() {
    currencyRepository = MockCurrencyRepository();
  });

  blocTest<FavoritesCubit, FavoriteState>(
    'Favorite cubit initialize correctly',
    build: () => FavoritesCubit(currencyRepository),
    verify: (cubit) {
      expect(cubit.state is FavoriteReadyState, true);

      final state = cubit.state as FavoriteReadyState;
      expect(state.currencies.length, 5);
      expect(state.currencies[0].key, 'EUR');
      expect(state.currencies[1].key, 'CNY');
      expect(state.currencies[2].key, 'USD');
      expect(state.currencies[3].key, 'JPY');
      expect(state.currencies[4].key, 'MXN');

      expect(state.selected.key, 'EUR');
    },
  );

  blocTest<FavoritesCubit, FavoriteState>(
    'Filters works correctly by key',
    build: () => FavoritesCubit(currencyRepository),
    act: (cubit) async {
      await Future.delayed(Duration(milliseconds: 1));
      cubit.filterCurrencies('MX');
    },
    verify: (cubit) {
      final state = cubit.state as FavoriteReadyState;
      expect(state.currencies.length, 1);
      expect(state.currencies[0].key, 'MXN');
    },
  );

  // blocTest<FavoritesCubit, FavoriteState>(
  //   'Filters works correctly by name',
  //   build: () => FavoritesCubit(currencyRepository),
  //   act: (cubit) async {
  //     await Future.delayed(Duration(milliseconds: 1));
  //     cubit.filterCurrencies('Mex');
  //   },
  //   expect: () => [
  //     isA<FavoriteReadyState>(),
  //     isA<FavoriteReadyState>(),
  //   ],
  //   verify: (cubit) {
  //     final state = cubit.state as FavoriteReadyState;
  //     expect(state.currencies.length, 1);
  //     expect(state.currencies[0].key, 'MXN');
  //   },
  // );
}
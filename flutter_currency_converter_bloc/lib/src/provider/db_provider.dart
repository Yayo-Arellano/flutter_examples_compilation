import 'package:flutter_currency_converter/src/model/currency.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  late Database _database;

  Future<DbProvider> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'currency9.db');
    _database = await openDatabase(path, version: 2, onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE currency
          (
            key TEXT PRIMARY KEY,
            name TEXT,
            value REAL,
            timestamp INTEGER
          )
        ''');
      await db.execute('''
           CREATE TABLE enabledCurrency
          (
           key TEXT PRIMARY KEY,
           position INTEGER
          )
        ''');

      await db.rawInsert('INSERT INTO enabledCurrency (key, position) VALUES ("EUR", 1)');
      await db.rawInsert('INSERT INTO enabledCurrency (key, position) VALUES ("CNY", 2)');
      await db.rawInsert('INSERT INTO enabledCurrency (key, position) VALUES ("USD", 3)');
      await db.rawInsert('INSERT INTO enabledCurrency (key, position) VALUES ("JPY", 4)');
      await db.rawInsert('INSERT INTO enabledCurrency (key, position) VALUES ("MXN", 5)');

      await db.execute('''
           CREATE TABLE selectedCurrency
          (
            id INTEGER PRIMARY KEY,
            key TEXT
          )
        ''');
      await db.rawInsert('INSERT INTO selectedCurrency (id, KEY) VALUES (1, "EUR")');
    });
    return this;
  }

  Future<int> insert(Currency item) {
    return _database.insert(
      'currency',
      item.toMapDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Currency>> getCurrencies() async {
    final query = '''
    SELECT 
      currency.key,
      currency.name,
      currency.value, 
      currency.timestamp,
      CASE 
        WHEN enabledCurrency.position IS NULL THEN
          -1
        ELSE
          enabledCurrency.position
        END position,
      CASE 
        WHEN enabledCurrency.key IS NULL THEN
          0
        ELSE
          1
        END isEnabled
    FROM
      currency
    LEFT JOIN
      enabledCurrency
    ON
      currency.key = enabledCurrency.key
    ORDER BY 
      isEnabled DESC,
      currency.key ASC
    ''';
    final result = await _database.rawQuery(query);
    return result.map((it) => Currency.fromMapDB(it)).toList();
  }

  Future<Currency> getCurrency(String key) async {
    final query = '''
    SELECT 
      currency.key,
      currency.name,
      currency.value, 
      currency.timestamp,
      CASE 
        WHEN enabledCurrency.position IS NULL THEN
          -1
        ELSE
          enabledCurrency.position
        END position,
      CASE 
        WHEN enabledCurrency.key IS NULL THEN
          0
        ELSE
          1
        END isEnabled
    FROM
      currency
    LEFT JOIN
      enabledCurrency
    ON
      currency.key = enabledCurrency.key
    WHERE
      currency.key=?
    ''';
    final result = await _database.rawQuery(query, [key]);
    return Currency.fromMapDB(result.first);
  }

  Future<int> getEnabledCurrencyCount() async {
    final result = await _database.rawQuery('SELECT COUNT(*) FROM enabledCurrency');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> enableCurrency(String key, int position) async {
    await _database.insert(
      'enabledCurrency',
      {
        'key': key,
        'position': position,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> disableCurrency(String key) async {
    await _database.delete(
      'enabledCurrency',
      where: 'key = ?',
      whereArgs: [key],
    );
  }

  Future<Currency> getSelectedCurrency() async {
    final result = await _database.query('selectedCurrency', columns: null, where: 'id = 1');
    return getCurrency(result.first['key'] as String);
  }

  Future<int> setSelectedCurrency(String key) {
    return _database.insert(
      'selectedCurrency',
      {
        'id': 1,
        'key': key,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

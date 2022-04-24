import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String key;
  final num value;
  final int timestamp;

  // Part 2. When I start creating the favorite cubit
  final bool isEnabled;
  final int position;

  Currency(this.key, this.value, this.timestamp, {this.position = -1, this.isEnabled = false});

  bool get isBase => key == 'EUR';

  @override
  List<Object?> get props => [key, value, timestamp, isEnabled];

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      'key': key,
      'value': value,
      'timestamp': timestamp,
    };
  }

  Currency.fromMapDB(Map<String, dynamic> dbData)
      : key = dbData['key'],
        value = dbData['value'],
        timestamp = dbData['timestamp'],
        isEnabled = dbData['isEnabled'] == 1,
        position = dbData['position'];
}

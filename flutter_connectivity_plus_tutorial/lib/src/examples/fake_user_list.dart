import 'package:flutter/material.dart';

final List<String> _fakeNames = [
  'Abigail',
  'Alexandra',
  'Alison',
  'Amanda',
  'Amelia',
  'Amy',
  'Andrea',
  'Angela',
  'Anna',
  'Anne',
  'Audrey',
  'Ava',
  'Bella'
];

class FakeUserList extends StatelessWidget {
  const FakeUserList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: _fakeNames.map((e) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(e),
            ),
          );
        }).toList(),
      ),
    );
  }
}

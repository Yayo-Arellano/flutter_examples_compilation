import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_localization/src/navigation/routes.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_an_option'.tr()),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.counterExample),
              child: Text('counter'.tr()),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.formExample),
              child: Text('form'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:page_indicator/page_indicator.dart';

// Replace with your client id
const googleClientId =
    '925019682416-duvllfhr13hub3fs150uekm6kh483eu1.apps.googleusercontent.com';

// Replace with your client id
const facebookClientId = 'xxxxxx';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: _IntroPager(),
    );
  }
}

class _IntroPager extends StatelessWidget {
  final String exampleText =
      'Lorem ipsum dolor sit amet, consecrated advising elit, '
      'sed do eiusmod tempor incididunt ut labore et '
      'dolore magna aliqua. Ut enim ad minim veniam.';

  @override
  Widget build(BuildContext context) {
    return PageIndicatorContainer(
      align: IndicatorAlign.bottom,
      length: 4,
      indicatorSpace: 12,
      indicatorColor: Colors.grey,
      indicatorSelectorColor: Colors.black,
      child: PageView(
        children: <Widget>[
          _DescriptionPage(
            text: exampleText,
            imagePath: 'assets/intro_1.png',
          ),
          _DescriptionPage(
            text: exampleText,
            imagePath: 'assets/intro_2.png',
          ),
          _DescriptionPage(
            text: exampleText,
            imagePath: 'assets/intro_3.png',
          ),
          _LoginPage(),
        ],
      ),
    );
  }
}

class _DescriptionPage extends StatelessWidget {
  final String text;
  final String imagePath;

  const _DescriptionPage({
    super.key,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SignInScreen(
      providerConfigs: [
        GoogleProviderConfiguration(clientId: googleClientId),
        FacebookProviderConfiguration(clientId: facebookClientId),
        EmailProviderConfiguration(),
      ],
    );
  }
}

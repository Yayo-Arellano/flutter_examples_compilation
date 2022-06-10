# Flutter Example: Unit testing [http](https://pub.dev/packages/http) requests

Flutter Version: Stable 2.0.0

In this example we are going to create an app using [Flutter Bloc](https://pub.dev/packages/flutter_bloc)

- Learn how to use manage states using bloc
- Separate the app in multiple layers (presentation, business logic, data)
- Make request to a Rest API using [Http](https://pub.dev/packages/http)
- Unit test & widget test
- Handle exceptions

# Prerequisites

- Get an API key from [https://newsapi.org/](https://newsapi.org/)
- Add the API key in the `NewsProvider` class

  ````
  class NewsProvider {
    static const String _apiKey = 'Change to your own api key';
  ````

- Run the command `flutter pub run build_runner watch --delete-conflicting-outputs` to generate the code.

# Screenshots

| Success Response                                | Handle ApiKey Invalid                           | Details                                         |
|-------------------------------------------------|-------------------------------------------------|-------------------------------------------------|
| <img src="screenshots/image1.png" height="520"> | <img src="screenshots/image2.png" height="520"> | <img src="screenshots/image3.png" height="520"> |


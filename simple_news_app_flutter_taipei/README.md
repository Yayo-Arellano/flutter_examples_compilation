# Simple News App using Cubit ([flutter_bloc](https://pub.dev/packages/flutter_bloc)): Flutter Festival Taipei

Flutter Version: Stable 2.10.3

- Learn how to use manage states using [cubit](https://pub.dev/packages/flutter_bloc)
- Separate the app in multiple layers (presentation, business logic, data)
- Make request to a Rest API using [http](https://pub.dev/packages/http)
- Unit test & widget test
- Handle exceptions

# Prerequisites

- Get an API key from [https://newsapi.org/](https://newsapi.org/)
- Add the API key in the `NewsSource` class

  ````
  class NewsSource {
    static const String _apiKey = 'Change to your own api key';
  ````

- Run the command `flutter pub run build_runner watch --delete-conflicting-outputs` to generate the code.

# Architecture
We separate in three layer:
- Presentation
- Business Logic
- Data: Repositories, Data sources.
  ![Architecture](https://github.com/Yayo-Arellano/flutter_bloc_architecture/blob/master/images/Architecture.png?raw=true)



# Screenshots

| Success Response | Handle ApiKey Invalid |
| ---------------- | --------------------- |
| ![Image 1](https://github.com/Yayo-Arellano/flutter_bloc_architecture/blob/master/images/Image%201.png?raw=true) |![Image 2](https://github.com/Yayo-Arellano/flutter_bloc_architecture/blob/master/images/Image%202.png?raw=true) |


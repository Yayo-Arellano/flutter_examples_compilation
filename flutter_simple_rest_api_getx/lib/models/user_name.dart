class UserName {
  final String title;
  final String first;
  final String last;

  UserName(this.title, this.first, this.last);

  UserName.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        first = json['first'],
        last = json['last'];
}
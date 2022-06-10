class UserPicture {
  final String thumbnail;

  UserPicture(this.thumbnail);

  UserPicture.fromJson(Map<String, dynamic> json)
      : thumbnail = json['thumbnail'];
}
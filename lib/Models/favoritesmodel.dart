class Favorite{
  bool ?status;
  String ?message;
  Favorite.fromJson(Map<String, dynamic> json) {
    status=json['status'];
    message= json['message'];
  }
}
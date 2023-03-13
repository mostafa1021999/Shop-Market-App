class Cart{
  bool ?status;
  String ?message;
  Cart.fromJson(Map<String, dynamic> json) {
    status=json['status'];
    message= json['message'];
  }
}
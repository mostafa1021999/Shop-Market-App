class HomeModel{
  bool ?status;
  HomeData ?data;
   HomeModel.fromJson(Map<String, dynamic> json) {
      status=json['status'];
      data= HomeData.fromJson(json['data']);
  }
}
class HomeData{
  List<Banner> banners=[];
  List<Productes> products=[];
   HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element){banners.add(Banner.fromJson(element));});
    json['products'].forEach((element){products.add(Productes.fromJson(element));});
   }
}

class Banner{
  int ?id;
  String ?image;
  Banner.fromJson(Map<String, dynamic> json) {
      id= json['status'];
      image= json['image'];
  }
}

class Productes{
  String? name;
  String? description;
  int ?id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  bool ?infavorites;
  bool ?incart;
  String ?image;
  List<String> images=[];
  Productes.fromJson(Map<String, dynamic> json) {
     id= json['id'];
    image=json['image'];
    price= json['price'];
    oldprice= json['old_price'];
    infavorites= json['in_favorites'];
    incart= json['in_cart'];
    discount= json['discount'];
    name=json['name'];
    description=json['description'];
     images = json['images'].cast<String>();
  }
}
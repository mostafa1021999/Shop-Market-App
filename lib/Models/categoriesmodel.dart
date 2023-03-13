class Categories{
  bool ?status;
  CategoriesData ?data;
  Categories.fromJson(Map<String, dynamic> json) {
    status=json['status'];
    data= CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData{
   int ?currentpage;
   List<DataCat> data=[];
   CategoriesData.fromJson(Map<String, dynamic> json) {
     currentpage=json['current_page'];
     json['data'].forEach((element){data.add(DataCat.fromJson(element));});
   }
}

class DataCat{
  String? name;
  String? description;
  int ?id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  bool ?infavorites;
  bool ?incart;
  String ?image;
  DataCat.fromJson(Map<String, dynamic> json) {
    id= json['id'];
    image=json['image'];
    price= json['price'];
    oldprice= json['old_price'];
    infavorites= json['in_favorites'];
    incart= json['in_cart'];
    discount= json['discount'];
    name=json['name'];
    description=json['description'];
  }
}
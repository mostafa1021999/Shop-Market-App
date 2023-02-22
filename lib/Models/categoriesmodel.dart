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
  int ?id;
  dynamic price;
  String ?image;
  dynamic oldPrice;
  int? discount;
  DataCat.fromJson(Map<String, dynamic> json) {
    id= json['id'];
    image=json['image'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    price = json['price'];
    name=json['name'];
  }
}
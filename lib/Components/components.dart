import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Cubit/app_cubit.dart';
import '../DIO/dio.dart';
import '../Models/homemodel.dart';
import '../Modules/login.dart';
import '../Modules/product description.dart';
import 'package:http/http.dart' as http;

import '../Modules/search.dart';
const log='login';
var arr = [];
bool isin=false;
bool payment=false;
bool isout=false;
int ?r;
int ?pric;
bool car=false;
bool newcar=false;
dynamic token='';
Color defaul=Colors.deepOrange;
Widget BuildArtical(artical) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage('${artical['urlToImage']}'),
                fit: BoxFit.cover,
              )
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                  child: Text('${artical['title']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,
                  ),
                    maxLines: 4,overflow: TextOverflow.ellipsis,
                  )),
              Text('${artical['publishedAt']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey))
            ],
          ),
        ),
      )

    ],
  ),
);
Widget Seperate() =>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.orangeAccent,
        width: 2,
      ),
    ),
    color: Colors.orangeAccent,
  )),
);

void Toasts(String mass , Color color) => Fluttertoast.showToast(
    msg: mass,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);
PageController pageController = PageController(
  initialPage: 0,
  keepPage: true,
);
void NavigateandFinish(context , Widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) => false);
void Navigate(context , Widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

Widget BuildProduc(model, context, {bool isoldprice = true,bool incart=false, incar,index}) {
  pric=PageCubit.get(context).incarts!.data!.total;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child:   InkWell(
      onTap: (){
        PageCubit.get(context).description(model.id);
        Navigate(context , Descriptions());},
      child:
      Container(
    height: 150,
        child:   Column(
          children: [
      Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                    alignment: Alignment.bottomLeft,
                    children:[ Image(image: NetworkImage('${model!.image}'),width: 120,
                      height: 150,
                    ),
                      if(model.discount!=0&& isoldprice )
                        Container(
                            color: defaul,
                            child: Text('Discount',style: TextStyle(color:Colors.white,fontSize: 14 ),))
                    ]
                ),

                Expanded(
                  child: Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${model.name}',maxLines: 2,overflow: TextOverflow.ellipsis,),
                          Spacer(),
                          if(incart==true)
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                    print(incar.quantity);
                                    if(incar.quantity==1) return;
                                  PageCubit.get(context).updatequantity(incar.id,  --incar.quantity);
                                },

                                    icon: CircleAvatar(
                                        backgroundColor:Colors.blueGrey,
                                        radius: 13,
                                        child: Icon(Icons.remove,size: 18,color: Colors.white,))),
                                Text('${PageCubit.get(context).incarts!.data!.cartItems![index].quantity}',style: TextStyle(fontSize: 15 ),),
                                IconButton(onPressed: (){
                                  print(incar.id);
                                  PageCubit.get(context).updatequantity(incar.id,  ++incar.quantity);

                                },
                                    icon: CircleAvatar(
                                        backgroundColor:Colors.blueGrey,
                                        radius: 13,
                                        child: Icon(Icons.add_sharp,size: 18,color: Colors.white,))),
                              ],),
                          Row(
                            children: [
                              Text('${model.price}',style: TextStyle(fontSize: 12 ),),
                              SizedBox(width: 5,),
                              Text('${model.oldPrice}',style: TextStyle(fontSize: 10 ,decoration: TextDecoration.lineThrough),),
                              Spacer(),
                              IconButton(onPressed: (){
                                PageCubit.get(context).changefave(model.id);
                              },
                                  icon: CircleAvatar(
                                      backgroundColor:PageCubit.get(context).favorites[model.id]?? false ? Colors.deepOrange :Colors.blueGrey,
                                      radius: 13,
                                      child: Icon(Icons.favorite_border,size: 14,color: Colors.white,))),
                              IconButton(onPressed: (){
                                if(incart==false){
                                for (var i = 0; i < arr.length; i++) {
                                  if(arr[i]== model.id)
                                  { arr.removeWhere( (item) => item == model.id );
                                  isout=true;}
                                }
                                if(isout==false)
                                  arr.add(model.id);
                                }else
                                  arr.removeWhere( (item) => item == model.id);
                                PageCubit.get(context).changecart(model.id);
                              },
                                  icon: CircleAvatar(
                                      backgroundColor: PageCubit.get(context).carts[model.id]?? false ? Colors.deepOrange :Colors.blueGrey ,
                                      radius: 13,
                                      child: const Icon(Icons.shopping_cart_checkout,size: 14,color: Colors.white,)))
                            ],
                          ),],),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
Widget BuildProduct(Productes? mod, context) => Container(
  child:   InkWell(
    onTap: (){
      print(mod!.id);
      PageCubit.get(context).description(mod.id);
      Navigate(context , Descriptions());
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
            alignment: Alignment.bottomLeft,
            children:[ Image(image: NetworkImage('${mod!.image}'),width: double.infinity,
              height: 200,
            ),
              if(mod.discount!=0)
                Container(
                    color: defaul,
                    child: const Text('Discount',style: TextStyle(color:Colors.white,fontSize: 14 ),))
            ]
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${mod.name}',maxLines: 2,overflow: TextOverflow.ellipsis,),
              Row(
                children: [
                  Text('${mod.price}',style: TextStyle(color:defaul,fontSize: 12, ),),
                  const SizedBox(width: 5,),
                  if(mod.discount!=0)
                    Text('${mod.oldprice}',style: const TextStyle(color:Colors.grey,fontSize: 10 ,decoration: TextDecoration.lineThrough),),
                  const Spacer(),
                  IconButton(onPressed: (){
                    PageCubit.get(context).changefave(mod.id);
                  },
                      icon: CircleAvatar(
                          backgroundColor: PageCubit.get(context).favorites[mod.id]?? false ? Colors.deepOrange :Colors.blueGrey ,
                          radius: 13,
                          child: const Icon(Icons.favorite_border,size: 14,color: Colors.white,))),
                  IconButton(onPressed: (){
                    for (var i = 0; i < arr.length; i++) {
                      if(arr[i]== mod.id)
                      { arr.removeWhere( (item) => item == mod.id );
                      isin=true;}
                    }
                    if(isin==false)
                      arr.add(mod.id);
                    PageCubit.get(context).changecart(mod.id);
                  },
                      icon: CircleAvatar(
                          backgroundColor: PageCubit.get(context).carts[mod.id]?? false ? Colors.deepOrange :Colors.blueGrey ,
                          radius: 13,
                          child: const Icon(Icons.shopping_cart_checkout,size: 14,color: Colors.white,)))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

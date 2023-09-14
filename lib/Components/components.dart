import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Modules/product description.dart';
const log='login';
var arr = [];
String dropdownvalue=Save.getdata(key: 'lang');
bool isin=false;
bool payment=false;
bool isout=false;
dynamic newtotal;
int ?pric;
bool car=false;
bool? isdark=Save.getdata(key: 'isdark');
bool newcar=false;
dynamic token='';
Color defaul=Colors.deepOrange;
Widget buildArtical(artical) => Padding(
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
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                  child: Text('${artical['title']}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,
                  ),
                    maxLines: 4,overflow: TextOverflow.ellipsis,
                  )),
              Text('${artical['publishedAt']}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey))
            ],
          ),
        ),
      )

    ],
  ),
);
Widget seperate() =>Padding(
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

void toasts(String mass , Color color) => Fluttertoast.showToast(
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
void navigateandFinish(context , Widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Widget), (route) => false);
void Navigate(context , Widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

Widget BuildProduc(model, context, {bool isoldprice = true,bool incart=false, incar,index}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child:   InkWell(
      onTap: (){
        PageCubit.get(context).description(model.id);
        Navigate(context , const Descriptions());},
      child:
      Directionality(
        textDirection: dropdownvalue=='اللغه العربيه' ?TextDirection.rtl:TextDirection.ltr,
        child: SizedBox(
    height: 170,
          child:   Column(
            children: [
        Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                      alignment: Alignment.bottomLeft,
                      children:[ CachedNetworkImage(imageUrl: '${model!.image}',width: 120,fit: BoxFit.fill,
                        placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        height: 140,
                      ),
                        if(model.discount!=0&& isoldprice )
                          Container(
                              color: defaul,
                              child: Text(dropdownvalue=='اللغه العربيه'?'تخفيض':'Discount' ,style: const TextStyle(color:Colors.white,fontSize: 14 ),))
                      ]
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${model.name}',maxLines:dropdownvalue=='اللغه العربيه'? 1 : 2,overflow: TextOverflow.ellipsis,),
                            if(incart==true)
                              Row(
                                children: [
                                  IconButton(onPressed: (){
                                      print(incar.quantity);
                                      if(incar.quantity==1) return;
                                    PageCubit.get(context).updatequantity(incar.id,  --incar.quantity);
                                    newtotal=newtotal-(1-model.price*incar.quantity);
                                    PageCubit.get(context).increment();
                                    },

                                      icon: const CircleAvatar(
                                          backgroundColor:Colors.blueGrey,
                                          radius: 13,
                                          child: Icon(Icons.remove,size: 18,color: Colors.white,))),
                                  Text('${PageCubit.get(context).incarts!.data!.cartItems![index].quantity}',style: const TextStyle(fontSize: 15 ),),
                                  IconButton(onPressed: (){
                                    PageCubit.get(context).updatequantity(incar.id,  ++incar.quantity);
                                    newtotal=newtotal+(model.price*incar.quantity-1);
                                    PageCubit.get(context).increment();

                                  },
                                      icon: const CircleAvatar(
                                          backgroundColor:Colors.blueGrey,
                                          radius: 13,
                                          child: Icon(Icons.add_sharp,size: 18,color: Colors.white,))),
                                ],),
                            const Spacer(),
                            Row(
                              children: [
                                Text('${model.price}',style: const TextStyle(fontSize: 10,color: Colors.deepOrange ),),
                                const SizedBox(width: 5,),
                                if(model.discount!=0)
                                Text('${model.oldPrice}',style: const TextStyle(fontSize: 8 ,decoration: TextDecoration.lineThrough),),
                                const Spacer(),
                                if(incart==true)
                                  iconbottom(model, context, (){
                                    PageCubit.get(context).changefave(model.id);
                                  }, Icons.favorite_border,PageCubit.get(context).favorites[model.id])
                                else
                                  iconbottom(model, context, (){
                                    PageCubit.get(context).changefave(model.id);
                                  }, Icons.delete_forever,PageCubit.get(context).favorites[model.id]),
                                if(incart==true)
                                  iconbottom(model, context, (){
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
                                  }, Icons.delete_forever,PageCubit.get(context).carts[model.id])
                                else
                                  iconbottom(model, context, (){
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
                                  }, Icons.shopping_cart_checkout,PageCubit.get(context).carts[model.id])
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
    ),
  );
}
Widget iconbottom(model,context,inpress,icon,back)=>IconButton(onPressed: inpress,
    icon: CircleAvatar(
        backgroundColor: back?? false ? Colors.deepOrange :Colors.blueGrey ,
        radius: 13,
        child:  Icon(icon,size: 14,color: Colors.white,)));

Widget BuildProduct(mod, context) => Container(
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
            children:[ CachedNetworkImage(
                placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: double.infinity,
              height: 200,
              imageUrl: '${mod!.image}',
            ),
              if(mod.discount!=0)
                Container(
                    color: defaul,
                    child: dropdownvalue=='اللغه العربيه' ?const Text('Discount',style: TextStyle(color:Colors.white,fontSize: 14 ),):
                    const Text('تخفيض',style: TextStyle(color:Colors.white,fontSize: 14 ),))
            ]
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: dropdownvalue=='اللغه العربيه'? CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              Text('${mod.name}',maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: dropdownvalue=='اللغه العربيه'?TextAlign.end:TextAlign.start,),
              Row(
                children: [
                  Text('${mod.price}',style: TextStyle(color:defaul,fontSize: 10, ),),
                  const SizedBox(width: 2,),
                  if(mod.discount!=0)
                    Text('${mod.oldprice.toInt()}',style: const TextStyle(color:Colors.grey,fontSize: 8 ,decoration: TextDecoration.lineThrough),),
                  const Spacer(),
                  IconButton(onPressed: (){
                    PageCubit.get(context).changefave(mod.id);
                  },
                      icon: CircleAvatar(
                          backgroundColor: PageCubit.get(context).favorites[mod.id]?? false ? Colors.deepOrange :Colors.blueGrey ,
                          radius: 12,
                          child: const Icon(Icons.favorite_border,size: 12,color: Colors.white,))),
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
                          radius: 12,
                          child: const Icon(Icons.shopping_cart_checkout,size: 12,color: Colors.white,)))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget Bottom(context,name,invarcar) =>Padding(
  padding: const EdgeInsets.only(top: 20.0),
  child:   Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Colors.blueGrey,),
      width: double.infinity,
      child: MaterialButton(onPressed: invarcar,
      child: Text(name , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white)),
      ),),
);
Widget? massage(state){
  if(state is FavoritesNotSuccess){
    if(state.model.status == false){
      toasts('${state.model.message}', Colors.red);
    }else{toasts('${state.model.message}', Colors.green);}
  }
  if(state is CartNotSuccess){
    if(state.model.status == false){
      toasts('${state.model.message}', Colors.red);
    }else{toasts('${state.model.message}', Colors.green);}
  }
}

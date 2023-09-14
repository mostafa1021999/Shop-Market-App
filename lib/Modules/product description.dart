import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/search.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Components/components.dart';
import '../Cubit/app_cubit.dart';
import '../Models/productmodel.dart';
import 'home.dart';
import 'login.dart';
class Descriptions extends StatelessWidget {
  const Descriptions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
      listener: (context, state) {
        massage(state);
      },
      builder: (context, state) {
        return  Scaffold(
              appBar: AppBar(
                title:  InkWell(
                    onTap: (){navigateandFinish(context,  Home(isdark));},
                    child:  const Text('Shop Market',overflow: TextOverflow.clip,style: TextStyle(fontSize: 19),)),
                actions: [
                  TextButton(onPressed: (){navigateandFinish(context, const Login());
                  Save.remove(key: 'token');}, child:Text(dropdownvalue=='اللغه العربيه'?'تسجيل خروج':'sign out' , style: const TextStyle(
                      color: Colors.white
                  ),)),
                  IconButton(
                    icon: const Icon(Icons.brightness_4_outlined),
                    onPressed: () {
                      AppCubit.get(context).changeapppmode()   ;
                      PageCubit.get(context).increment();
                    },
                  ),
                  IconButton(onPressed: (){Navigate(context, Search());}, icon:const  Icon(Icons.search),)],
              ),
              body: ConditionalBuilder(
                  condition:  state is !GetProductLoading,
                  builder:(context)=>buildProduc(PageCubit.get(context).prodescrip,context),
                  fallback: (context)=> Center(child: Lottie.asset('assets/Comp.json'),),
        ),
        );
      },
    );
  }
  Widget buildProduc(PoductesDes? mod, context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:dropdownvalue=='اللغه العربيه'? CrossAxisAlignment.end:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${mod!.data!.name}',style:const TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
          textAlign: dropdownvalue=='اللغه العربيه' ?TextAlign.end :TextAlign.start ,),
          const SizedBox(height: 10,),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                  alignment: Alignment.bottomLeft,
                  children:[ ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CarouselSlider(items: mod.data!.images!.map((e) => CachedNetworkImage(imageUrl: e,
                      placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      width: double.infinity,
                      fit: BoxFit.fill,)).toList(), options: CarouselOptions(initialPage:0,height: 250,autoPlay: true,autoPlayInterval:const Duration(seconds: 3),
                        viewportFraction: 1.0, autoPlayAnimationDuration: const Duration(seconds: 3),enableInfiniteScroll: true,
                        autoPlayCurve: Curves.fastLinearToSlowEaseIn
                    )),
                  ),
                    if(mod.data!.discount!=0)
                      Container(
                          color: defaul,
                          child:    Text(dropdownvalue=='اللغه العربيه'? 'تخفيض':'Discount',style: const TextStyle(color:Colors.white,fontSize: 14 ),))
                  ]
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Positioned(child: FloatingActionButton(
                  elevation: 2,
                  child:const Icon(Icons.favorite_border,color: Colors.white,),
                  backgroundColor: PageCubit.get(context).favorites[mod.data!.id]?? false ? Colors.deepOrange :Colors.blueGrey,
                  onPressed: (){
                    PageCubit.get(context).changefave(mod.data!.id);
                  }
              ),
                bottom: 0,
                left: 20,
              ),
              Positioned(child: FloatingActionButton(
                elevation: 2,
                child:const Icon(Icons.shopping_cart_checkout,color: Colors.white),
                backgroundColor:  PageCubit.get(context).carts[mod.data!.id]?? false ? Colors.deepOrange :Colors.blueGrey,
                onPressed: (){
                  PageCubit.get(context).changecart(mod.data!.id);
                }
            ),
              bottom: 0,
              right: 20,
            ),
              ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle
                    ),
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.all(5),
                  ),
                  Container(
                    decoration:const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle
                    ),
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.all(5),
                  ),
                  Container(
                    decoration:const BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle
                    ),
                    width: 30,
                    height: 30,
                    margin:const EdgeInsets.all(5),
                  ),
                ],),
              Column(
                children: <Widget>[
                   Text(dropdownvalue=='اللغه العربيه'? 'السعر':"price",style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("${mod.data!.price} E£",
                    style: TextStyle(
                      color: defaul,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  if(mod.data!.discount!=0)
                    Text('${mod.data!.oldPrice} E£',style: const TextStyle(color:Colors.grey,fontSize: 10 ,decoration: TextDecoration.lineThrough),),
                ],
              )
            ],),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment:dropdownvalue=='اللغه العربيه'?CrossAxisAlignment.end: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                   Text(dropdownvalue=='اللغه العربيه'?'مواصفات المنتج' :'PRODUCT DETAILS',style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
                const SizedBox(height: 15,),
                Text('${mod.data!.description}',style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),textAlign: dropdownvalue=='اللغه العربيه'?TextAlign.end:TextAlign.start,),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
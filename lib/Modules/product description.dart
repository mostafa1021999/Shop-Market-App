import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import '../Components/components.dart';
import '../Models/productmodel.dart';
import 'home.dart';
import 'login.dart';
class Descriptions extends StatelessWidget {
  const Descriptions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return  Scaffold(
              appBar: AppBar(title: InkWell(
                  onTap: (){NavigateandFinish(context,  Home(isdark));},
                  child: const Text('Shop Market')),),
              body: ConditionalBuilder(
                  condition:  state is !GetProductLoading,
                  builder:(context)=>buildProduc(PageCubit.get(context).prodescrip,context),
                  fallback: (context)=> const Center(child: CircularProgressIndicator(),),
        ),
        );
      },
    );
  }
  Widget buildProduc(PoductesDes? mod, context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('${mod!.data!.name}',style:const TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 10,),
          Center(
            child: Stack(
                alignment: Alignment.bottomLeft,
                children:[ ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CarouselSlider(items: mod.data!.images!.map((e) => Image(image: NetworkImage(e,),
                    width: double.infinity,
                    fit: BoxFit.fill,)).toList(), options: CarouselOptions(initialPage:0,height: 250,autoPlay: true,autoPlayInterval:const Duration(seconds: 3),
                      viewportFraction: 1.0, autoPlayAnimationDuration: const Duration(seconds: 3),enableInfiniteScroll: true,
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn
                  )),
                ),
                  if(mod.data!.discount!=0)
                    Container(
                        color: defaul,
                        child: const Text('Discount',style: TextStyle(color:Colors.white,fontSize: 14 ),))
                ]
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Color"),
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
                    ],)

                ],
              ),
              Column(
                children: <Widget>[
                  const Text("price",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("${mod.data!.price}",
                    style: TextStyle(
                      color: defaul,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  if(mod.data!.discount!=0)
                    Text('${mod.data!.oldPrice}',style: const TextStyle(color:Colors.grey,fontSize: 10 ,decoration: TextDecoration.lineThrough),),
                ],
              )
            ],),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15,),
                const Text('Product Details',style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),),
                Text('${mod.data!.description}',style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
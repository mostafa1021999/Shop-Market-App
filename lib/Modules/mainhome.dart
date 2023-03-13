import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Models/categoriesmodel.dart';
import 'package:stripe_payment_integration/Models/homemodel.dart';
import '../Components/components.dart';
import 'categoriesDetails.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit,PageState>(builder: (context,state){
      var list= PageCubit.get(context).page;
      var list2= PageCubit.get(context).catego;
      return ConditionalBuilder(condition: PageCubit.get(context).page != null &&
          PageCubit.get(context).catego != null ,
          builder: (context)=> SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: topProduct(list!,list2!,context)),
          fallback: (context)=> Center(child: Lottie.asset('assets/Comp.json')));
    }, listener: (context, state) {
      massage(state);
    }

    );
  }
  Widget topProduct(HomeModel ?model,Categories? cat, context) => Padding(
    padding: const EdgeInsets.all(10.0),
    child:   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: dropdownvalue=='اللغه العربيه'? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        CarouselSlider(items: model!.data!.banners.map((e) => CachedNetworkImage(
            placeholder: (context,url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl: '${e.image}',
          width: double.infinity,
          fit: BoxFit.cover,)).toList(), options: CarouselOptions(initialPage:0,height: 250,autoPlay: true,autoPlayInterval:const Duration(seconds: 3),
            viewportFraction: 1.0, autoPlayAnimationDuration: const Duration(seconds: 1),enableInfiniteScroll: true,
            autoPlayCurve: Curves.fastLinearToSlowEaseIn
        )),
        const SizedBox(height: 20,),
        Text(dropdownvalue=='اللغه العربيه'?'الاصناف':'Categories',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,
        ),),
        const SizedBox(height: 10,),
        SizedBox(
          height: 100,
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=>category(cat!.data!.data[index],context), separatorBuilder: (context,index)=>const SizedBox(width: 10,), itemCount: cat!.data!.data.length),
        ),
        const SizedBox(height: 10,),
        Text(dropdownvalue=='اللغه العربيه'?'المنتجات الجديدة':'New Products',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,)),
        GridView.count(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          childAspectRatio: 1/1.9,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: 2,children: List.generate(model.data!.products.length,
                (index)=> BuildProduct( model.data!.products[index], context)), )
      ],
    ),
  );


  Widget category(DataCat modul,context){return InkWell(
    onTap: (){
      PageCubit.get(context).CategorieDtails(modul.id);
      Navigate(context , const CategoriesDetails());
    },
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [CachedNetworkImage(
          height: 100,fit: BoxFit.cover,
          width: 100,
           imageUrl:'${modul.image}',
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context,url) => const Center(child: CircularProgressIndicator()),),
        Container(color: Colors.black.withOpacity(.7),
          width: 100,
          child: Text('${modul.name}',maxLines: 1,textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white,fontSize: 18),),
        )
      ],),
  );}
}
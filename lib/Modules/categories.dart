import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Models/categoriesmodel.dart';

import '../Components/components.dart';
import 'categoriesDetails.dart';

class Categor extends StatelessWidget {
  const Categor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
  listener: (context, state) {
    massage(state);
  },
  builder: (context, state) {
    return ConditionalBuilder(
      condition:PageCubit.get(context).page !=null ,
      fallback: (context)=>  Center(child: Lottie.asset('assets/Comp.json'),),
      builder:(context)=> Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(itemBuilder: (context,index)=>catego(PageCubit.get(context).catego!.data!.data[index],context), separatorBuilder:(context,index) =>const Padding(padding:  EdgeInsets.all(10.0),),
            itemCount: PageCubit.get(context).catego!.data!.data.length),
      ),
    );
  },
);
  }
}

Widget catego(DataCat modul,context){return InkWell(
  onTap: (){
    PageCubit.get(context).CategorieDtails(modul.id);
    Navigate(context , const CategoriesDetails());
  },
  child:   Directionality(
    textDirection: dropdownvalue=='اللغه العربيه' ?TextDirection.rtl:TextDirection.ltr,
    child: Container(
      height: 100,
      decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.deepOrange),borderRadius:const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          CachedNetworkImage( height: 80,fit: BoxFit.cover,
              placeholder: (context,url) => Center(child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_1OPxxN.json')),
              width: 80,
              imageUrl: '${modul.image}'),
          const SizedBox(width: 10,),
          Text('${modul.name}',maxLines: 1,textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
  ),
);}



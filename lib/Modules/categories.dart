import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  },
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(itemBuilder: (context,index)=>catego(PageCubit.get(context).catego!.data!.data[index],context), separatorBuilder:(context,index) =>Seperate(),
          itemCount: PageCubit.get(context).catego!.data!.data.length),
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
  child:   Row(
    children: [
      Image( height: 100,fit: BoxFit.cover,
          width: 100,
          image: NetworkImage('${modul.image}')),
      const SizedBox(width: 10,),
      Text('${modul.name}',maxLines: 1,textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
    ],
  ),
);}



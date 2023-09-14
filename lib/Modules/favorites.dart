import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';

import '../Components/components.dart';

class Favor extends StatelessWidget {
  const Favor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return BlocConsumer<PageCubit, PageState>(
          listener: (context, state) {
            massage(state);
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: PageCubit.get(context).favor !=null,
              builder: (BuildContext context) =>Column(
                children: [
                    if(state is! GetFavoritesSuccess && state is FavoritesChangeSuccess )
                    const Padding(
                      padding:  EdgeInsets.all(20.0),
                      child: LinearProgressIndicator(),
                    ),
                  if(PageCubit.get(context).favor!.data!.data!.isEmpty)
                     Expanded(child: Padding(
                      padding:const  EdgeInsets.only(top: 250.0),
                      child: Center(child: Text(dropdownvalue=='اللغه العربيه'?'لا توجد منتجات فى المفضله':'No Items In Favorite',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),),
                    )),
                  Expanded(
                    child: ListView.separated(itemBuilder: (context,index)=>BuildProduc(PageCubit.get(context).favor!.data!.data![index].product,context,incar: false), separatorBuilder:(context,index) =>seperate(),
                        itemCount: PageCubit.get(context).favor!.data!.data!.length),
                  ),
                ],
              ),
              fallback: (BuildContext context) =>Center(child: Lottie.asset('assets/Comp.json')),
            );
          },
        );
  }
}



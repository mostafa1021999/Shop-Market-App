import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';

import '../Components/components.dart';

class Favor extends StatelessWidget {
  const Favor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return BlocConsumer<PageCubit, PageState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: state is !GetFavoritesLoading,
              builder: (BuildContext context) =>Column(
                children: [
                    if(state is! GetFavoritesSuccess && state is FavoritesChangeSuccess )
                    const Padding(
                      padding:  EdgeInsets.all(20.0),
                      child: LinearProgressIndicator(),
                    ),
                  if(PageCubit.get(context).favor!.data!.data!.isEmpty)
                    const Expanded(child: Padding(
                      padding:  EdgeInsets.only(top: 250.0),
                      child: Center(child: Text('No Items In Favorite',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),),
                    )),
                  Expanded(
                    child: ListView.separated(itemBuilder: (context,index)=>BuildProduc(PageCubit.get(context).favor!.data!.data![index].product,context), separatorBuilder:(context,index) =>Seperate(),
                        itemCount: PageCubit.get(context).favor!.data!.data!.length),
                  ),
                ],
              ),
              fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(),),
            );
          },
        );
  }
}



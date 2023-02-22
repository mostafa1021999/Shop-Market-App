import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/product%20description.dart';
import 'package:stripe_payment_integration/Modules/search.dart';
import '../Components/components.dart';
import '../Cubit/app_cubit.dart';
import '../Models/categoriesmodel.dart';
import '../Shared Prefence/share_prefrence.dart';
import 'home.dart';
import 'login.dart';

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:  InkWell(
                onTap: (){NavigateandFinish(context,  Home(isdark));},
                child: const Text('Shop Market')),
            actions: [
              TextButton(onPressed: (){NavigateandFinish(context, Login());
              Save.remove(key: 'token');}, child:const Text('sign out',style: TextStyle(
                  color: Colors.white
              ),)),
              IconButton(
                icon: const Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  AppCubit.get(context).changeapppmode();
                },
              ),
              IconButton(onPressed: (){Navigate(context, Search());}, icon:const  Icon(Icons.search),)],
          ),
          body: ConditionalBuilder(
            condition:  state is !GetCategoriesDetailsLoading,
            builder: (context)=>GridView.count(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              childAspectRatio: 1/1.9,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: 2,children: List.generate(PageCubit.get(context).catdetail!.data!.data.length,
                    (index)=> buildcategories( PageCubit.get(context).catdetail!.data!.data[index], context)), ),
            fallback: (context)=> const Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
}

Widget buildcategories(DataCat? mod, context) => InkWell(
  onTap: (){
    PageCubit.get(context).description(mod!.id);
    Navigate(context , const Descriptions());
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
                  Text('${mod.oldPrice}',style: const TextStyle(color:Colors.grey,fontSize: 10 ,decoration: TextDecoration.lineThrough),),
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
);

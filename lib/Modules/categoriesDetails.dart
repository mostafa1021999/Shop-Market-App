import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/search.dart';
import '../Components/components.dart';
import '../Cubit/app_cubit.dart';
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
                onTap: (){navigateandFinish(context,  Home(isdark));},
                child: const Text('Shop Market',overflow: TextOverflow.clip,style: TextStyle(fontSize: 19),)),
            actions: [
              TextButton(onPressed: (){navigateandFinish(context, const Login());
              Save.remove(key: 'token');}, child:Text(dropdownvalue=='اللغه العربيه'?'تسجيل خروج':'sign out' ,style: const TextStyle(
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
            condition:  state is !GetCategoriesDetailsLoading,
            builder: (context)=>GridView.count(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              childAspectRatio: 1/1.9,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: 2,children: List.generate(PageCubit.get(context).catdetail!.data!.data.length,
                    (index)=> BuildProduct( PageCubit.get(context).catdetail!.data!.data[index], context)), ),
            fallback: (context)=> Center(child: Lottie.asset('assets/Comp.json'))
          ),
        );
      },
    );
  }
}


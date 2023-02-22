import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/app_cubit.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/login.dart';
import 'package:stripe_payment_integration/Modules/search.dart';
import 'package:stripe_payment_integration/Modules/user_profile.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Components/components.dart';
import 'cart.dart';
import 'categories.dart';
import 'favorites.dart';
import 'mainhome.dart';

class Home extends StatelessWidget {
  final bool? isdark;
  const Home(this.isdark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.deepOrange,
                  currentIndex: PageCubit.get(context).current,
                  onTap: (index) {
                    PageCubit.get(context).changenavigator(index);
                    pageController.jumpToPage(index);
                  },
                  items: PageCubit.get(context).bottom),
              appBar: AppBar(
                  title: const Text('Shop Market'),
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
              body:PageView(
                controller: pageController,
                onPageChanged: (index) {
                  PageCubit.get(context).changenavigator(index);
                },
                children: <Widget>[
                  const MainPage(),
                  const Categor(),
                  const Cart(),
                  const Favor(),
                  UserProfile(),
                ],
              )
          );
        },
      );
  }
}

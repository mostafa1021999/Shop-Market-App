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
        },
        builder: (context, state) {
          return Scaffold(
              bottomNavigationBar: Theme(
                data :ThemeData(
                  canvasColor: AppCubit.get(context).isdark==false? Colors.black54:Colors.deepOrange,
                ),
                child: BottomNavigationBar(
                    unselectedItemColor:Colors.white,
                    currentIndex: PageCubit.get(context).current,
                    onTap: (index) {
                      PageCubit.get(context).changenavigator(index);
                      pageController.jumpToPage(index);
                    },
                    items: dropdownvalue=='اللغه العربيه'?PageCubit.get(context).bottomar:PageCubit.get(context).bottomen ),
              ),
              appBar: AppBar(
                  title: const Text('Shop Market'),
                actions: [
                  TextButton(onPressed: (){navigateandFinish(context, Login());
                  Save.remove(key: 'token');}, child: Text(dropdownvalue=='اللغه العربيه'?'تسجيل خروج':'sign out' ,style: const TextStyle(
                    color: Colors.white
                  ),)),
                  IconButton(
                    icon: const Icon(Icons.brightness_4_outlined),
                    onPressed: () {
                      AppCubit.get(context).changeapppmode();
                      PageCubit.get(context).increment();
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/login.dart';
import 'package:stripe_payment_integration/Modules/shop.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import 'Components/components.dart';
import 'Cubit/app_cubit.dart';
import 'DIO/dio.dart';
import 'Modules/home.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
  'pk_test_51MWIzPKNFf4yjl9RrNSjDN3uQKQejxe1Gnc3cygHI9ohlZAMT3tTYGt69guKqtiT6F6kFbYLCiibS9z7zSytESxF00GTWRtif7';
  await Save.init();
  DioHelper.init();
  bool ?onboard = Save.getdata(key: 'save');
  token = Save.getdata(key: 'token');
  Widget widget;
  if(onboard != null){
    if(token !=null){
      widget=Home(isdark);
    }
    else {
      widget=const Login();
    }
  }else {
    widget=const Shop();
  }
  runApp(
      MyApp(widget,)
  );
}
class MyApp extends StatelessWidget {
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    dividerColor: Colors.white54,
  );
  final Widget start;
  MyApp(this.start, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return     MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => PageCubit()..homepage()..catetory()..getfavorites()..getprofile()..getcart()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changeapppmode(formshare: isdark)),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.deepOrange, iconTheme: const IconThemeData(color: Colors.deepOrange),

              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black12,
                ),
              ),),
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.transparent,
              ),      textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
              primarySwatch: Colors.grey,
              primaryColor: Colors.black,
              brightness: Brightness.dark,
              backgroundColor: const Color(0xFF212121),
              dividerColor: Colors.black12,
              appBarTheme: const AppBarTheme(
                color: Colors.black54,
                systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black54,),
              ),),
            themeMode: AppCubit.get(context).isdark? ThemeMode.light:ThemeMode.dark ,
            home: start,
          );
        },
      ),
    );
  }
}
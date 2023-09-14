import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Modules/register.dart';

import '../Components/components.dart';
import '../Cubit/app_cubit.dart';
import '../Cubit/page_cubit.dart';
import '../Shared Prefence/share_prefrence.dart';
import 'home.dart';
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController(), passwordcontroller=TextEditingController();
    var formkey=GlobalKey<FormState>();
    return BlocProvider(
  create: (context) => PageCubit(),
  child: BlocConsumer<PageCubit, PageState>(
  listener: (context, state) {
    if(state is LoginSuccess){
      if((state.loger.status)!){
        toasts((state.loger.message)!, Colors.green);
        Save.savedata(key: 'token', value: state.loger.data!.token).then((value){
          token=state.loger.data!.token;
          navigateandFinish(context,  Home(isdark));
        });
      }else{
        toasts((state.loger.message)!, Colors.red);
      }
    }
  },
  builder: (context, state) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: AppCubit.get(context).isdark?[
                  Colors.deepOrange,
                  Colors.orange,
                  Colors.deepOrange
                ]:[
                  Colors.black12,
                  Colors.grey,
                  Colors.grey
                ]
            )
        ),
        child: Directionality(
          textDirection: dropdownvalue=='اللغه العربيه' ?TextDirection.rtl:TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(dropdownvalue=='اللغه العربيه' ?'تسجيل الدخول':'Login', style: const TextStyle(color: Colors.white, fontSize: 40),),
                    const SizedBox(height: 10,),
                    Text(dropdownvalue=='اللغه العربيه' ?'مرحبا بعودتك مجددا':'Welcome Back', style: const TextStyle(color: Colors.white, fontSize: 18),),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppCubit.get(context).isdark? Colors.white :Colors.black,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 30,),
                             CircleAvatar(
                              backgroundColor: AppCubit.get(context).isdark? Colors.white :Colors.black,
                                radius: 50,
                                backgroundImage: const AssetImage('assets/ecommerce2.png')),
                            const SizedBox(height: 30,),
                             Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'? 'ادخل حساب صحيح':'enter valid email';}
                                      return null;
                                    },
                                    controller: emailcontroller,
                                    decoration:  InputDecoration(label: Text(dropdownvalue=='اللغه العربيه'?'الحساب':'Email Address') , prefixIcon:const Icon(Icons.email) , border: const OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  Container(
                                    decoration:const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                                    ),
                                      child: const SizedBox(height: 30,)),
                                  TextFormField(
                                    onFieldSubmitted:(value){
                                      if(formkey.currentState!.validate()){
                                        PageCubit.get(context).userlogin(email: emailcontroller.text,
                                            password: passwordcontroller.text);}
                                    },
                                    validator: (value){
                                      if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'? 'ادخل كلمه مرور صحيحه صحيح':'enter valid password';}
                                      return null;
                                    },
                                    controller: passwordcontroller,
                                    decoration: InputDecoration(label:  Text(dropdownvalue=='اللغه العربيه'? 'كلمه المرور':'Password') ,
                                      prefixIcon: const Icon(Icons.lock) ,
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(onPressed: (){PageCubit.get(context).changepasstype();}, icon: Icon(PageCubit.get(context).icon)),
                                    ),
                                    keyboardType: TextInputType.visiblePassword, obscureText: PageCubit.get(context).type,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20,),
                            ConditionalBuilder(builder: (context) =>
                                Container(
                                  width: double.infinity,
                                  color: Colors.deepOrange,child: MaterialButton(onPressed: (){
                                  if(formkey.currentState!.validate()){
                                    PageCubit.get(context).userlogin(email: emailcontroller.text,
                                        password: passwordcontroller.text);}

                                },
                                  child:  Text(dropdownvalue=='اللغه العربيه'?'تسجل الدخول':'Login'  , style: const TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white)),
                                ),), condition: state is ! LoginLoading, fallback: (context) => const Center(child: CircularProgressIndicator(),),),

                            Directionality(
                              textDirection:dropdownvalue=='اللغه العربيه'?TextDirection.rtl: TextDirection.ltr  ,
                              child: Row(
                                children : [  Text(dropdownvalue=='اللغه العربيه'?'لا تمتلك حساب':"Don't have account" ),
                                  TextButton(onPressed: (){Navigate(context, Register());}, child:  Text(dropdownvalue=='اللغه العربيه'? 'سجل الان':'Register now',style: const TextStyle(color: Colors.deepOrange),))

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}
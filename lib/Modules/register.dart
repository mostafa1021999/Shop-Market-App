import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Components/components.dart';
import '../Cubit/app_cubit.dart';
import '../Cubit/register_cubit.dart';
import '../Shared Prefence/share_prefrence.dart';
import 'home.dart';
class Register extends StatelessWidget {
  var emailcontroller = TextEditingController(),
      passwordcontroller=TextEditingController(),
      namecontroller=TextEditingController(),
      phonecontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();

  Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is Registersuccess){
            if((state.loger.status)!){
              toasts((state.loger.message)!, Colors.green);
              Save.savedata(key: 'token', value: state.loger.data!.token).then((value){
                token=state.loger.data!.token;
                navigateandFinish(context, Home(isdark));
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
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 80,),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(dropdownvalue=='اللغه العربيه'?'تسجيل':"Register", style: const TextStyle(color: Colors.white, fontSize: 40,),),
                          const SizedBox(height: 10,),
                          Text(dropdownvalue=='اللغه العربيه'?'سجل الان لتجنى المزيد من العروض':'Register now to browse our offers', style: const TextStyle(color: Colors.white, fontSize: 18),),
                        ],
                      ),
                    ),
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
                                  const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage('assets/ecommerce2.png')),
                                 const SizedBox(height: 30,),
                                  Column(
                                    children: <Widget>[
                                      TextFormField(
                                        validator: (value){
                                          if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'? 'ادخل اسمك':'enter your name';}
                                          return null;
                                        },
                                        controller: namecontroller,
                                        decoration:  InputDecoration(label: Text(dropdownvalue=='اللغه العربيه'?'الاسم':'Name') , prefixIcon: const Icon(Icons.person) , border: const OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.name,
                                      ),
                                      const SizedBox(height: 30,),
                                      TextFormField(
                                        validator: (value){
                                          if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'? 'ادخل حساب صحيح':'enter vaild email';}
                                          return null;
                                        },
                                        controller: emailcontroller,
                                        decoration:  InputDecoration(label: Text(dropdownvalue=='اللغه العربيه'? 'الحساب':'Email Address') , prefixIcon: const Icon(Icons.email) , border: const OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                      const SizedBox(height: 30,),
                                      TextFormField(
                                        onFieldSubmitted:(value){
                                          if(formkey.currentState!.validate()){
                                            RegisterCubit.get(context).userregister(
                                              name:namecontroller.text,
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text,
                                              phone: phonecontroller.text,
                                            );}
                                        },
                                        validator: (value){
                                          if(value!.isEmpty){return 'enter valid password';}
                                          return null;
                                        },
                                        controller: passwordcontroller,
                                        decoration: InputDecoration(label:  Text(dropdownvalue=='اللغه العربيه'?'كلمه المرور':'Password') ,
                                          prefixIcon: const Icon(Icons.lock) ,
                                          border: const OutlineInputBorder(),
                                          suffixIcon: IconButton(onPressed: (){RegisterCubit.get(context).changepasstype();}, icon: Icon(RegisterCubit.get(context).icon)),
                                        ),
                                        keyboardType: TextInputType.visiblePassword, obscureText: RegisterCubit.get(context).type,
                                      ),
                                      const SizedBox(height: 30,),
                                      TextFormField(
                                        validator: (value){
                                          if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'?'ادخل رقم هاتف صحيح': 'enter valid phone number';}
                                          return null;
                                        },
                                        controller: phonecontroller,
                                        decoration: InputDecoration(label: Text(dropdownvalue=='اللغه العربيه'?'رقم الهاتف':'Phone Number') , prefixIcon: const Icon(Icons.phone) , border:const OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  ConditionalBuilder(builder: (context) =>
                                      Container(
                                        width: double.infinity,
                                        color: Colors.deepOrange,child: MaterialButton(onPressed: (){
                                        if(formkey.currentState!.validate()){
                                          RegisterCubit.get(context).userregister(
                                            name:namecontroller.text,
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text,
                                            phone: phonecontroller.text,
                                          );}

                                      },
                                        child: Text(dropdownvalue=='اللغه العربيه'? 'تسجيل':'Register' , style:const TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white)),
                                      ),), condition: state is ! Registerloading, fallback: (context) => const Center(child: CircularProgressIndicator(),),),

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
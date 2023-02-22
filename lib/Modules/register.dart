import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/register_cubit.dart';
import 'package:stripe_payment_integration/Modules/home.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Components/components.dart';
import 'login.dart';
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
              Toasts((state.loger.message)!, Colors.green);
              Save.savedata(key: 'token', value: state.loger.data!.token).then((value){
                token=state.loger.data!.token;
                NavigateandFinish(context, Home(isdark));
              });
            }else{
              Toasts((state.loger.message)!, Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title: const Text('Shop Market'),),
              body:
              Center(
                child: SingleChildScrollView(
                  child: Padding(padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [

                          const   Text('Register',
                              style :  TextStyle(fontWeight: FontWeight.bold , fontSize: 40 ,  )
                          ),
                          const   Text('Register now to browse our offers',
                              style :  TextStyle( fontSize: 20 , color: Colors.black38 )
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            validator: (value){
                              if(value!.isEmpty){return 'enter your name';}
                              return null;
                            },
                            controller: namecontroller,
                            decoration: const InputDecoration(label: Text('Name') , prefixIcon: Icon(Icons.person) , border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            validator: (value){
                              if(value!.isEmpty){return 'enter vaild email';}
                              return null;
                            },
                            controller: emailcontroller,
                            decoration: const InputDecoration(label: Text('Email Address') , prefixIcon: Icon(Icons.email) , border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15,),
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
                            decoration: InputDecoration(label: const Text('Password') ,
                              prefixIcon: const Icon(Icons.lock) ,
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(onPressed: (){RegisterCubit.get(context).changepasstype();}, icon: Icon(RegisterCubit.get(context).icon)),
                            ),
                            keyboardType: TextInputType.visiblePassword, obscureText: RegisterCubit.get(context).type,
                          ),
                          const SizedBox(height: 15,),
                          TextFormField(
                            validator: (value){
                              if(value!.isEmpty){return 'enter valid phone number';}
                              return null;
                            },
                            controller: phonecontroller,
                            decoration: const InputDecoration(label: Text('Phone Number') , prefixIcon: Icon(Icons.phone) , border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15,),
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
                                child: const Text('Register' , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25)),
                              ),), condition: state is ! Registerloading, fallback: (context) => const Center(child: CircularProgressIndicator(),),),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}

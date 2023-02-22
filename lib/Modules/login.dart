import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/register.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Components/components.dart';
import 'home.dart';
bool? isdark=Save.getdata(key: 'isdark');
class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var emailcontroller = TextEditingController(), passwordcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageCubit(),
      child: BlocConsumer<PageCubit, PageState>(
        listener: (context, state) {
          if(state is LoginSuccess){
            if((state.loger.status)!){
              Toasts((state.loger.message)!, Colors.green);
              Save.savedata(key: 'token', value: state.loger.data!.token).then((value){
                token=state.loger.data!.token;
                NavigateandFinish(context,  Home(isdark));
              });
            }else{
              Toasts((state.loger.message)!, Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(title:const Text('Shop Market'),),
              body:
              Padding(padding: const EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [

                      const   Text('Login',
                          style :  TextStyle(fontWeight: FontWeight.bold , fontSize: 40 ,  )
                      ),
                      const   Text('Login now to browse our offers',
                          style :  TextStyle( fontSize: 20 , color: Colors.black38 )
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
                            PageCubit.get(context).userlogin(email: emailcontroller.text,
                                password: passwordcontroller.text);}
                        },
                        validator: (value){
                          if(value!.isEmpty){return 'enter vaild password';}
                          return null;
                        },
                        controller: passwordcontroller,
                        decoration: InputDecoration(label: const Text('Password') ,
                          prefixIcon: const Icon(Icons.lock) ,
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(onPressed: (){PageCubit.get(context).changepasstype();}, icon: Icon(PageCubit.get(context).icon)),
                        ),
                        keyboardType: TextInputType.visiblePassword, obscureText: PageCubit.get(context).type,
                      ),
                      const SizedBox(height: 15,),
                      ConditionalBuilder(builder: (context) =>
                          Container(
                            width: double.infinity,
                            color: Colors.deepOrange,child: MaterialButton(onPressed: (){
                            if(formkey.currentState!.validate()){
                              PageCubit.get(context).userlogin(email: emailcontroller.text,
                                  password: passwordcontroller.text);}

                          },
                            child: const Text('Login' , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25)),
                          ),), condition: state is ! LoginLoading, fallback: (context) => const Center(child: CircularProgressIndicator(),),),

                      Row(
                        children : [ const Text("Don't have account"),
                          TextButton(onPressed: (){Navigate(context, Register());}, child:const  Text('Register now'))

                        ],
                      )
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}

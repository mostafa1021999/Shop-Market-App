import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Components/components.dart';
import 'login.dart';

class UserProfile extends StatelessWidget {
  var emailcontroller = TextEditingController(),
      phonecontroller=TextEditingController(),
      namecontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();

  UserProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var model=PageCubit.get(context).user;
    namecontroller.text=model!.data!.name!;
    emailcontroller.text=model.data!.email!;
    phonecontroller.text=model.data!.phone!;
    return ConditionalBuilder(
      condition:true ,
      fallback: (context)=> const Center(child: CircularProgressIndicator(),),

      builder:(context)=> Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(children: [
              if(state is UpdateUserLoading)
              const LinearProgressIndicator(),
              const SizedBox(height: 15,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){return 'Name must not empty';}
                  return null;
                },
                controller: namecontroller,
                decoration: const InputDecoration(label: Text('name') , prefixIcon: Icon(Icons.person) , border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 15,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){return 'Email must not empty';}
                  return null;
                },
                controller: emailcontroller,
                decoration: const InputDecoration(label: Text('Email Address') , prefixIcon: Icon(Icons.email) , border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){return 'Phone must not empty';}
                  return null;
                },
                controller: phonecontroller,
                decoration: const InputDecoration(label: Text('phone') , prefixIcon: Icon(Icons.phone) , border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.deepOrange,),
                  width: double.infinity,
                  child: MaterialButton(onPressed: (){
                  if(formkey.currentState!.validate()){
                    PageCubit.get(context).userprofileupdate(
                        name: namecontroller.text,
                        email: emailcontroller.text,
                        phone: phonecontroller.text);}
                },
                  child: const Text('UPDATE' , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white)),
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.deepOrange,),
                  width: double.infinity,
                  child: MaterialButton(onPressed: (){
                    NavigateandFinish(context, Login());
                    Save.remove(key: 'token');

                },
                  child: const Text('LOGOUT' , style: TextStyle( fontWeight: FontWeight.bold , fontSize: 25,color: Colors.white)),
                ),),
              ),

            ],),
          ),
        ),
      ),
    );
  },
);
  }
}

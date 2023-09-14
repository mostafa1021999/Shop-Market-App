import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
    var items = [
      'English Language',
      'اللغه العربيه',
    ];
    var model=PageCubit.get(context).user;
    namecontroller.text=model!.data!.name!;
    emailcontroller.text=model.data!.email!;
    phonecontroller.text=model.data!.phone!;
    return ConditionalBuilder(
      condition:true,
      fallback: (context)=> Center(child: Lottie.asset('assets/Comp.json')),

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
                  if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'?'ادخل الاسم':'Name must not empty';}
                  return null;
                },
                controller: namecontroller,
                decoration:  InputDecoration(label: dropdownvalue=='اللغه العربيه'?const Text('الاسم'):const Text('name') , prefixIcon: const Icon(Icons.person) , border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 15,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'?'ادخل الحساب':'Email must not empty';}
                  return null;
                },
                controller: emailcontroller,
                decoration:  InputDecoration(label:dropdownvalue=='اللغه العربيه'?const Text('الحساب'):const Text('Email Address') , prefixIcon:const Icon(Icons.email) , border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15,),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){return dropdownvalue=='اللغه العربيه'?'ادخل رقم هاتفك':'Phone must not empty';}
                  return null;
                },
                controller: phonecontroller,
                decoration:  InputDecoration(label:dropdownvalue=='اللغه العربيه'? const Text('رقم الهاتف'):const Text('phone') , prefixIcon:const Icon(Icons.phone) , border:const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15,),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, border:  Border.all(color:Colors.blueGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      style: const TextStyle(color: Colors.blueGrey,fontSize: 20,fontWeight: FontWeight.bold),

                      dropdownColor: Colors.white,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down,color: Colors.blueGrey,size: 25,),
                      isExpanded: true,
                      value :dropdownvalue ,

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        Save.savedata(key: 'lang', value:newValue ).then((value){
                          PageCubit.get(context).chnagelanguage(newValue);
                          PageCubit.get(context).homepage();
                          PageCubit.get(context).getprofile();
                          PageCubit.get(context).catetory();
                          PageCubit.get(context).getfavorites();
                          PageCubit.get(context).getcart();
                        });
                        Save.savedata(key: 'lang', value:newValue ).then((value){
                          PageCubit.get(context).chnagelanguage(newValue);
                          PageCubit.get(context).homepage();
                          PageCubit.get(context).getprofile();
                          PageCubit.get(context).catetory();
                          PageCubit.get(context).getfavorites();
                          PageCubit.get(context).getcart();
                        });
                      },
                    ),
                  ),
                ),
              Bottom(context, dropdownvalue=='اللغه العربيه'? 'تعديل':'UPDATE', (){
                if(formkey.currentState!.validate()){
                  PageCubit.get(context).userprofileupdate(
                      name: namecontroller.text,
                      email: emailcontroller.text,
                      phone: phonecontroller.text);}
              },),
              Bottom(context, dropdownvalue=='اللغه العربيه'? 'تسجيل الخروج': 'LOGOUT',(){
                navigateandFinish(context, const Login());
                Save.remove(key: 'token');
              },),

            ],),
          ),
        ),
      ),
    );
  },
);
  }
}

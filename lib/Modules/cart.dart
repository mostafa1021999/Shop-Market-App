import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/payment%20controller.dart';
import '../Components/components.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
      listener: (context, state) {
        massage(state);
      },
      builder: (context, state) {
        final PaymentController controller = Get.put(PaymentController());
        return ConditionalBuilder(
          condition: PageCubit.get(context).incarts !=null,
          builder: (BuildContext context) =>Column(
            children: [
              if(state is! GetCartsSuccess && state is CartChangeSuccess )
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LinearProgressIndicator(),
                ),
              if(PageCubit.get(context).incarts!.data!.total==0)
                 Expanded(child: Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Center(child: Text(dropdownvalue=='اللغه العربيه'?'لا توجد منتجات فى العربه':'No Items In Cart',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),),
                )),
                Expanded(
                child: ListView.separated(itemBuilder: (context,index)=>BuildProduc(PageCubit.get(context).incarts!.data!.cartItems![index].product,context,incar:PageCubit.get(context).incarts!.data!.cartItems![index],incart: true,index: index), separatorBuilder:(context,index) =>seperate(),
                    itemCount: PageCubit.get(context).incarts!.data!.cartItems!.length),
              ),
              if(PageCubit.get(context).incarts!.data!.total!=0)
                Center(
                child: Expanded(child: Padding(
                  padding: const EdgeInsets.all(20.0),

                  child:
                  Bottom(context,'Pay ${PageCubit.get(context).incarts!.data!.total}', (){

         controller.makePayment(amount: '5', currency: 'USD' , ).then((e){
        if(payment==true){
        for (var i = 0; i < arr.length; i++) {
        PageCubit.get(context).changecart(arr[i]);
        }
        arr=[];
        payment=false;
        }
        });
        },)
                )),
              )
            ],
          ),
          fallback: (BuildContext context) =>Center(child: Lottie.asset('assets/Comp.json')),
        );
      },
    );
  }
}
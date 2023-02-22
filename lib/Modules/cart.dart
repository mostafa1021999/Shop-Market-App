import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import 'package:stripe_payment_integration/Modules/payment%20controller.dart';

import '../Components/components.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        final PaymentController controller = Get.put(PaymentController());
        return ConditionalBuilder(
          condition: state is !GetCartsLoading,
          builder: (BuildContext context) =>Column(
            children: [
              if(state is! GetCartsSuccess && state is CartChangeSuccess )
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LinearProgressIndicator(),
                ),
              if(PageCubit.get(context).incarts!.data!.total==0)
                const Expanded(child: Padding(
                  padding: EdgeInsets.only(top: 250.0),
                  child: Center(child: Text('No Items In Cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),),
                )),
                Expanded(
                child: ListView.separated(itemBuilder: (context,index)=>BuildProduc(PageCubit.get(context).incarts!.data!.cartItems![index].product,context,incar:PageCubit.get(context).incarts!.data!.cartItems![index],incart: true,index: index), separatorBuilder:(context,index) =>Seperate(),
                    itemCount: PageCubit.get(context).incarts!.data!.cartItems!.length),
              ),
              if(PageCubit.get(context).incarts!.data!.total!=0)
                Center(
                child: Expanded(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () async{

                        await controller.makePayment(amount: '${PageCubit.get(context).incarts!.data!.total}', currency: 'USD' , ).then((e){
                          if(payment==true){
                            for (var i = 0; i < arr.length; i++) {
                              PageCubit.get(context).changecart(arr[i]);
                            }
                            arr=[];
                            payment=false;
                          }
                        });
                      },
                child: Container(
                      decoration: const BoxDecoration(color: Colors.deepOrange,borderRadius: BorderRadius.all(Radius.circular(25))),
                      height: 50,
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Text('pay '
                        ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                          Text('${PageCubit.get(context).incarts!.data!.total}',
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                      ],),),
                  ),
                )),
              )
            ],
          ),
          fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
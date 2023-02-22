import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Components/components.dart';
import 'login.dart';
var boardController=PageController();

class Shop extends StatelessWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void submit(){
      Save.savedata(key: 'save', value: true).then((value) {
        if(value){
          NavigateandFinish(context ,Login());
        }
      });
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Shop Market'),actions: [TextButton(onPressed: (){
        submit();
        },
            child: const Text('Skip', style: TextStyle(color: Colors.white),))],),
        body: PageView(
          physics:const BouncingScrollPhysics(),
          controller: boardController,
          children: <Widget>[
            onBoarding(0,'Welcome In Shop Market App','Continuous to get offers','https://thumbs.dreamstime.com/b/e-commerce-orange-square-button-isolated-reflected-abstract-illustration-104715752.jpg',false,context),
            onBoarding(1,'Save Your Money With Shop Money','Continuous to get offers','https://images.cdn1.stockunlimited.net/preview1300/online-shopping-wallpaper_1820079.jpg',false,context),
            onBoarding(2,'Get Started Now','Continuous to get offers','https://img.freepik.com/premium-vector/shopping-online-store-via-mobile-phone-bags-shopping-cart-gift-boxes-standing-upon-podium_181870-168.jpg',true,context),
          ],
        )
    );
  }
}

Widget onBoarding(int ind,String maintext,String secondtext,String image,bool statue,context)=>Expanded(
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SizedBox(
        width: 450,
        height: 400,
        child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(image)),
      ),

      const SizedBox(height: 50,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(statue)
            TextButton(onPressed: (){
              Save.savedata(key: 'save', value: true).then((value) {
              if(value){
                NavigateandFinish(context ,Login());
              }
            });},
              child: Text(maintext,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.deepOrange
              ),),
            ),
          if(!statue)
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 10),
            child: Text(maintext,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.deepOrange
            ),),
          ),
          const SizedBox(height: 15,),
          Text(secondtext,style: const TextStyle(fontSize: 15,color: Colors.grey),),
        ],
      ),
      const SizedBox(height: 180,),
      Expanded(
        child: Container(
          height: 40,
          color: Colors.deepOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: SmoothPageIndicator(controller: boardController,count: 3  ,
                    effect: const ExpandingDotsEffect(dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 10,
                        activeDotColor: Colors.white
                    )),
              ),
              MaterialButton(onPressed: (){
                if (ind== 2){
                  Save.savedata(key: 'save', value: true).then((value) {
                    if(value){
                      NavigateandFinish(context ,Login());
                    }
                  });
                }
                else{
                  boardController.nextPage(duration: const Duration(
                      milliseconds: 750
                  ), curve: Curves.fastLinearToSlowEaseIn);}
              },child: const Text('Continuous', style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400)),
              )
            ],
          ),
        ),
      ),
    ],
  ),
);


import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
import '../Components/components.dart';
import 'login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

var boardController=PageController();

class Shop extends StatelessWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Save.savedata(key: 'lang', value:'English Language' );
    void submit(){
      Save.savedata(key: 'save', value: true).then((value) {
        Save.savedata(key: 'lang', value:'English Language' ).then((value){
        if(value){
          navigateandFinish(context ,const Login());
        }});
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
            onBoarding(0,'Welcome In Shop Market App','https://thumbs.dreamstime.com/b/e-commerce-orange-square-button-isolated-reflected-abstract-illustration-104715752.jpg',context),
            onBoarding(1,'Save Your Money With Shop Market','https://images.cdn1.stockunlimited.net/preview1300/online-shopping-wallpaper_1820079.jpg',context),
            onBoarding(2,'Get Started Now','https://img.freepik.com/premium-vector/shopping-online-store-via-mobile-phone-bags-shopping-cart-gift-boxes-standing-upon-podium_181870-168.jpg',context),
          ],
        )
    );
  }
}

Widget onBoarding(int ind,String maintext,String image,context)=>Expanded(
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      SizedBox(
        width: 450,
        height: 350,
        child: CachedNetworkImage(imageUrl:image,
                fit: BoxFit.fill,
          placeholder: (context,url) =>  const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
      ),

      const SizedBox(height: 100,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0,),
            child: ind== 2?
  InkWell(
    onTap: (){Save.savedata(key: 'save', value: true).then((value) {
      Save.savedata(key: 'lang', value:'English Language' ).then((value){
        if(value){
          navigateandFinish(context ,const Login());
        }});
    });},
    child: Text(maintext,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.deepOrange
),
    overflow: TextOverflow.clip,
    maxLines: 1,
    softWrap: false,),
  )
      :Text(maintext,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.deepOrange
            ),
              overflow: TextOverflow.clip,
              maxLines: 1,
              softWrap: false,),
          ),
          const SizedBox(height: 15,),
         const Text('Continuous to get offers',style:  TextStyle(fontSize: 15,color: Colors.grey),),
        ],
      ),
      const Spacer(),
      Container(
        height: 70,
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
              Save.savedata(key: 'lang', value:'English Language' ).then((value){
                  if(value){
                    navigateandFinish(context ,const Login());
                  }});
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
    ],
  ),
);


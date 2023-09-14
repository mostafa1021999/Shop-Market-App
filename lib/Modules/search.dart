import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/page_cubit.dart';
import '../Components/components.dart';
import 'home.dart';

class Search extends StatelessWidget {
  var textcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();

  Search({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageCubit, PageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(elevation: 0, title: InkWell(
                onTap: (){navigateandFinish(context,  Home(isdark));},
                child: const Text('Shop Market')),),
            body: Form(
              key: formkey,
              child: Column(
                  children: [ Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){return 'Enter text to search';}
                        return null;
                      },
                      onFieldSubmitted: (String text){
                        PageCubit.get(context).search(text: text);
                      },
                      controller: textcontroller,
                      decoration: const InputDecoration(label: Text('search'),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                    if(state is SearchLoading)
                      const Padding(
                        padding:  EdgeInsets.all(20.0),
                        child: LinearProgressIndicator(),
                      ),
                    if(state is SearchSuccess)
                    Expanded(
                      child: ListView.separated(itemBuilder: (context,index)=>BuildProduc(PageCubit.get(context).searches!.data!.data[index],context,isoldprice: false), separatorBuilder:(context,index) =>seperate(),
                          itemCount: PageCubit.get(context).searches!.data!.data.length),
                    ),
                  ]
              ),
            )
        );
      },
    );
  }
}

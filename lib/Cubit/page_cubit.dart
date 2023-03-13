import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment_integration/Cubit/app_cubit.dart';
import 'package:stripe_payment_integration/DIO/dio.dart';
import 'package:stripe_payment_integration/Models/cartsmodel.dart';
import 'package:stripe_payment_integration/Models/categoriesmodel.dart';
import 'package:stripe_payment_integration/Models/chanefavoritemodel.dart';
import 'package:stripe_payment_integration/Models/changecarts.dart';
import 'package:stripe_payment_integration/Models/favoritesmodel.dart';
import 'package:stripe_payment_integration/Models/homemodel.dart';
import 'package:stripe_payment_integration/Models/loginmodel.dart';
import 'package:stripe_payment_integration/Models/serach%20model.dart';
import '../Components/components.dart';
import '../Models/productmodel.dart';
part 'page_state.dart';

class PageCubit extends Cubit<PageState> {

  PageCubit() : super(PageInitial());
  static PageCubit get(context) => BlocProvider.of(context);
  ShopLog ?l;
  bool type= true;
  IconData icon=Icons.visibility_off_outlined;
  void changepasstype(){
    type =!type;
    icon =  type ?  Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SetPass());
  }
  Incart ?carte;


  void clearcart(int? productid){
    carts[productid] =! (carts[productid]?? false);
    DioHelper.postData(url: 'carts', data:{ 'product_id' : productid},
        token: token).then((value) {
      carte= Incart.fromJson(value.data);
      emit(ClearCartSuccess());
    }).catchError((error) {
      carts[productid] =! (carts[productid]?? false);
      emit(ClearCartError());
    });
  }

  void increment(){
    emit(Reload());
  }
  void chnagelanguage(r){
    dropdownvalue = r;
    emit(chnagelanguagesuccess());
  }

  void userlogin({
    required String email,
    required String password
  }){
    emit(LoginLoading());
    DioHelper.postData(url: 'login', data: {
      'email' : email,
      'password' : password,
    }).then((value) {
      l= ShopLog.fromJson(value.data);
      emit(LoginSuccess(l!));
    }).catchError((error) {
      emit(LoginError(error.toString()));
    });
  }
  int current = 0;
  List<BottomNavigationBarItem> bottomen = [
    const BottomNavigationBarItem(icon:  Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.apps_outlined),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
      label: 'Chart',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.settings),
      label: 'settings',

    ),
  ];
  List<BottomNavigationBarItem> bottomar = [
    const BottomNavigationBarItem(icon:  Icon(Icons.home),
      label: 'الرئيسيه',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.apps_outlined),
      label: 'الاصناف',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
      label: 'العربه',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite),
      label: 'المفضله',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.settings),
      label: 'الاعدادت',

    ),
  ];
  void changenavigator(int index) {
    current = index;
    emit(OtherState());
  }
  HomeModel? page;
  Map<int?, bool?> favorites={};
  Map<int?, bool?> carts={};
  void homepage(){
    emit(HomeLoading());
    DioHelper.getData(url: 'home',
      token: token,
    ).then((value) {
      page=HomeModel.fromJson(value.data);
      page!.data!.products.forEach((element) {favorites.addAll({element.id: element.infavorites});});
      page!.data!.products.forEach((element) {carts.addAll({element.id: element.incart});});
      emit(HomeSuccess());
    }).catchError((error) {
      emit(HomeError());
    });
  }
  Categories ?catego;
  void catetory(){
    emit(CategoriesLoading());
    DioHelper.getData(url: 'categories',
      token: token,
    ).then((value) {
      catego=Categories.fromJson(value.data);
      emit(CategoriesSuccess());
    }).catchError((error) {
      emit(CategoriesError());
    });}

  Favorite? fave;
  void changefave(int? productid){
    favorites[productid] =! (favorites[productid]?? false);
    emit(FavoritesChangeSuccess());
    DioHelper.postData(url: 'favorites', data:{ 'product_id' : productid},
        token: token).then((value) {
      fave= Favorite.fromJson(value.data);
      if(fave!.status ==false){
        favorites[productid] =! (favorites[productid]?? false);
      }else{
        getfavorites();
      }
      emit(FavoritesNotSuccess(fave!));
    }).catchError((error) {
      favorites[productid] =! (favorites[productid]?? false);
      emit(FavoritesError());
    });
  }
  Faveroites ?favor;
  void getfavorites(){
    emit(GetFavoritesLoading());
    DioHelper.getData(url: 'favorites',
      token: token,
    ).then((value) {
      favor=Faveroites.fromJson(value.data);
      emit(GetFavoritesSuccess());
    }).catchError((error) {
      emit(GetFavoritesError());
    });}
  ShopLog? user;
  void getprofile(){
    emit(GetUserLoading());
    DioHelper.getData(url: 'profile',
      token: token,
    ).then((value) {
      user=ShopLog.fromJson(value.data);
      emit(GetUserSuccess());
    }).catchError((error) {
      emit(GetUserError());
    });}

  void userprofileupdate({required String name,
    required String email,
    required String phone,}){
    emit(UpdateUserLoading());
    DioHelper.putData(url: 'update-profile',
        token: token,
        data: {
          'name' : name,
          'email' : email,
          'phone' : phone,
        }
    ).then((value) {
      user=ShopLog.fromJson(value.data);

      emit(UpdateUserSuccess(user!));
    }).catchError((error) {
      emit(UpdateUserError());
    });}

  SearchModel? searches;
  void  search({
    required String text,
  }){
    emit(SearchLoading());
    DioHelper.postData(url: 'products/search',token: token ,data: {
      'text' : text,
    }).then((value) {
      searches= SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((error) {
      emit(SearchError(error.toString()));
    });
  }

  Cart? car;
  void changecart(int? productid){
    carts[productid] =! (carts[productid]?? false);
    emit(CartChangeSuccess());
    DioHelper.postData(url: 'carts', data:{ 'product_id' : productid},
        token: token).then((value) {
      car= Cart.fromJson(value.data);
      if(car!.status ==false){
        carts[productid] =! (carts[productid]?? false);
      }else{
        getcart();
      }
      emit(CartNotSuccess(car!));
    }).catchError((error) {
      carts[productid] =! (carts[productid]?? false);
      emit(CartError());
    });
  }
  Incart ?incarts;
  void getcart(){
    emit(GetCartsLoading());
    DioHelper.getData(url: 'carts',
      token: token,
    ).then((value) {
      incarts=Incart.fromJson(value.data);
      incarts!.data!.cartItems!.forEach((element) {
        int check = 0;
        for(int i=0 ;i<arr.length ; i++ ){
          if(arr[i]==element.product!.id) {
            check++;
          }
        }
        if(check== 0 )
         arr.add(element.product!.id);
      });
      emit(GetCartsSuccess());
    }).catchError((error) {
      emit(GetCartsError());
    });}
  dynamic total;
  void updatequantity(cartId ,quantity){
    DioHelper.putData(url: 'carts/${cartId}',
        token: token,
        data: {
          'quantity' : quantity,
        }
    ).then((value) {
      getcart();
      emit(UpdateCartsSuccess());
      }).catchError((error) {
        emit(UpdateCartsError());
      });
  }
  PoductesDes? prodescrip;
  void description(proId){
    emit(GetProductLoading());
    DioHelper.getData(url: 'products/${proId}',
      token: token,
    ).then((value) {
      prodescrip=PoductesDes.fromJson(value.data);
      emit(GetProductSuccess());
    }).catchError((error) {
      emit(GetProductError());
    });
  }
  Categories? catdetail;
  void CategorieDtails(catId){
    emit(GetCategoriesDetailsLoading());
    DioHelper.getData(url: 'categories/${catId}',
      token: token,
    ).then((value) {
      catdetail=Categories.fromJson(value.data);
      emit(GetCategoriesDetailsSuccess());
    }).catchError((error) {
      emit(GetCategoriesDetailsError());
    });
  }
}
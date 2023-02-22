import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment_integration/Models/loginmodel.dart';
import '../DIO/dio.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  ShopLog ?l;
  bool type= true;
  IconData icon=Icons.visibility_off_outlined;
  void changepasstype(){
    type =!type;
    icon =  type ?  Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(Registersetpass());
  }

  void userregister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(Registerloading());
    DioHelper.postData(url: 'register', data: {
      'name' : name,
      'email' : email,
      'password' : password,
      'phone' : phone,
    }).then((value) {print(value.data);
    l= ShopLog.fromJson(value.data);
    emit(Registersuccess(l!));
    }).catchError((error) {
      print('error when bring data ${error.toString()}');
      emit(Registererror(error.toString()));
    });
  }
}

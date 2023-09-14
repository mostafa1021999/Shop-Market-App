import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment_integration/Shared%20Prefence/share_prefrence.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppcubitInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isdark = false;

  void changeapppmode({bool? formshare}) {
    if (formshare != null) {
      isdark = formshare;
      emit(ChangeMode());
    }
    else {
      isdark = !isdark;
      Save.putdata(key: 'isdark', value: isdark).then((value) =>
          emit(ChangeMode()));
    }
  }


}

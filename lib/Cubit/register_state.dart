part of 'register_cubit.dart';
@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class Registerloading extends RegisterState{}

class Registersuccess extends RegisterState{
  final ShopLog loger;
  Registersuccess(this.loger);
}

class Registererror extends RegisterState{
  final String error;
  Registererror(this.error);
}

class Registersetpass extends RegisterState{}
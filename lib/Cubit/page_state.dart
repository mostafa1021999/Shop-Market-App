part of 'page_cubit.dart';

@immutable
abstract class PageState {}

class PageInitial extends PageState {}

class SetPass extends PageState {}

class ChangeMode extends PageState{}
class Reload extends PageState {}

class ClearCartSuccess extends PageState {}

class ClearCartError extends PageState {}

class LoginLoading extends PageState{}

class LoginSuccess extends PageState{
  final ShopLog loger;
  LoginSuccess(this.loger);
}

class LoginError extends PageState{
  final String error;
  LoginError(this.error);
}

class chnagelanguagesuccess extends PageState{}

class OtherState extends PageState{}

class HomeLoading extends PageState{}

class HomeSuccess extends PageState{}

class HomeError extends PageState{}

class CategoriesLoading extends PageState{}

class CategoriesSuccess extends PageState{}

class CategoriesError extends PageState{}

class FavoritesChangeSuccess extends PageState{

}

class FavoritesNotSuccess extends PageState{
  final Favorite model;
  FavoritesNotSuccess(this.model);
}

class FavoritesError extends PageState{}

class GetFavoritesLoading extends PageState{}

class GetFavoritesSuccess extends PageState{}

class GetFavoritesError extends PageState{}

class GetUserLoading extends PageState{}

class GetUserSuccess extends PageState{}

class GetUserError extends PageState{}

class UpdateUserLoading extends PageState{}

class UpdateUserSuccess extends PageState{
  final ShopLog loger;
  UpdateUserSuccess(this.loger);
}
class UpdateUserError extends PageState{}

class SearchLoading extends PageState{}

class SearchSuccess extends PageState{}

class SearchError extends PageState{
  final String error;
  SearchError(this.error);
}

class ProLoading extends PageState{}

class ProSuccess extends PageState{}

class ProError extends PageState{}

class CartChangeSuccess extends PageState{}

class CartNotSuccess extends PageState{
  final Cart model;
  CartNotSuccess(this.model);
}

class CartError extends PageState{}

class GetCartsLoading extends PageState{}

class GetCartsSuccess extends PageState{}

class GetCartsError extends PageState{}

class UpdateCartsError extends PageState{}

class UpdateCartsSuccess extends PageState{}

class GetProductLoading extends PageState{}

class GetProductSuccess extends PageState{}

class GetProductError extends PageState{}

class GetCategoriesDetailsLoading extends PageState{}

class GetCategoriesDetailsSuccess extends PageState{}

class GetCategoriesDetailsError extends PageState{}
part of 'main_bloc.dart';

@immutable
abstract class MainState extends BaseBlocState {}

class MainInitial extends BaseBlocState {}

@immutable
abstract class BaseGroceriesState extends BaseBlocState {
  const BaseGroceriesState(this.products);

  final List<GroceryProduct> products;
}

@immutable
class GetAllGroceriesState extends BaseGroceriesState {
  const GetAllGroceriesState(List<GroceryProduct> products) : super(products);
}

@immutable
class AddGroceryState extends BaseGroceriesState {
  const AddGroceryState(List<GroceryProduct> products) : super(products);
}

@immutable
class RemoveGroceryState extends BaseGroceriesState {
  const RemoveGroceryState(List<GroceryProduct> products) : super(products);
}

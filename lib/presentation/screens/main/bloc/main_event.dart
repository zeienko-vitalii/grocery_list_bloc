part of 'main_bloc.dart';

@immutable
abstract class MainEvent extends BaseEvent {}

class GetAllGroceriesEvent extends MainEvent {}

class AddGroceryEvent extends MainEvent {
  AddGroceryEvent(this.product);

  final GroceryProduct product;
}

class RemoveGroceryEvent extends MainEvent {
  RemoveGroceryEvent(this.product);

  final GroceryProduct product;
}

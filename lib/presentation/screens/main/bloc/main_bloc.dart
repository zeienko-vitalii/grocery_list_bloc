import 'dart:async';

import 'package:list_tracker_app/data/net/models/grocery_product.dart';
import 'package:list_tracker_app/presentation/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends BaseBloc {
  final List<GroceryProduct> _groceries = <GroceryProduct>[];

  @override
  Stream<BaseBlocState> mapChildEventToState(BaseEvent event) async* {
    if (event is GetAllGroceriesEvent) {
      yield LoadingState(event);
      yield await _getGroceries();
    } else if (event is AddGroceryEvent) {
      yield LoadingState(event);
      yield await _addGrocery(event.product);
    } else if (event is RemoveGroceryEvent) {
      yield LoadingState(event);
      yield await _removeGroceries(event.product);
    } else {
      yield SuccessState(event);
    }
  }

  Stream<List<GroceryProduct>> getAllItems() {
    return groceryDataSourceImpl.allItems().handleError(_handleError).map((List<GroceryProduct> event) {
      _groceries.clear();
      _groceries.addAll(event);
      return _groceries;
    });
  }

  Future<List<GroceryProduct>> _getAllGroceries() {
    return groceryDataSourceImpl.fetchAllItems().catchError(_handleError);
  }

  /// One-time fetch of all groceries
  Future<BaseBlocState> _getGroceries() {
    return _getAllGroceries().then((List<GroceryProduct> value) {
      return GetAllGroceriesState(value);
    });
  }

  /// Adds grocery and fetches them with [_getAllGroceries]
  Future<BaseBlocState> _addGrocery(GroceryProduct product) {
    return groceryDataSourceImpl.addItems(product).then((_) {
      return _getAllGroceries().then((List<GroceryProduct> value) => AddGroceryState(value));
    }).catchError(_handleError);
  }

  /// Removes product by id and fetches them with [_getAllGroceries]
  Future<BaseBlocState> _removeGroceries(GroceryProduct product) {
    return groceryDataSourceImpl.removeItem(product).then((_) {
      return _getAllGroceries().then((List<GroceryProduct> value) => RemoveGroceryState(value));
    }).catchError(_handleError);
  }

  /// Prints error and returns [ErrorState]
  Future<BaseBlocState> _handleError(Object error) async {
    print(error);
    return ErrorState(error);
  }
}

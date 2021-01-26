import 'dart:async';

import 'package:list_tracker_app/data/net/models/grocery_product.dart';
import 'package:list_tracker_app/presentation/base/bloc/base_bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

/// Bloc for Main screen
class MainBloc extends BaseBloc {

  /// Cached groceries
  final List<GroceryProduct> _groceries = <GroceryProduct>[];

  @override
  Stream<BaseBlocState> mapChildEventToState(BaseEvent event) async* {
    if (event is AddGroceryEvent) {
      await _addGrocery(event.product);
    } else if (event is RemoveGroceryEvent) {
      await _removeGroceries(event.product);
    }
    yield SuccessState(event);
  }

  /// Fetches data in realtime
  Stream<List<GroceryProduct>> getAllItemsStream() {
    return groceryDataSourceImpl.allItemsStream().handleError(_handleError).map((List<GroceryProduct> event) {
      _groceries
        ..clear()
        ..addAll(event);
      return _groceries;
    });
  }

  /// Adds grocery and fetches them with [_getAllGroceries]
  Future<void> _addGrocery(GroceryProduct product) {
    return groceryDataSourceImpl.addItems(product).catchError(_handleError);
  }

  /// Removes product by id and fetches them with [_getAllGroceries]
  Future<void> _removeGroceries(GroceryProduct product) {
    return groceryDataSourceImpl.removeItem(product).catchError(_handleError);
  }

  /// Prints error and returns [ErrorState]
  Future<BaseBlocState> _handleError(Object error) async {
    print(error);
    return ErrorState(error);
  }
}

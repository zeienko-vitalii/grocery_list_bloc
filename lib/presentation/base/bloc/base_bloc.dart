import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:list_tracker_app/data/net/datasource/datasource.dart';
import 'package:list_tracker_app/data/net/firestore/firestore_impl.dart';
import 'package:list_tracker_app/data/net/models/grocery_product.dart';
import 'package:meta/meta.dart';

part 'base_event.dart';

part 'base_state.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseBlocState> {
  BaseBloc() : super(const InitialBaseState());

  @protected
  DataSource<GroceryProduct> groceryDataSourceImpl = FireStoreImpl();

  @override
  Stream<BaseBlocState> mapEventToState(BaseEvent event) => mapChildEventToState(event);

  Stream<BaseBlocState> mapChildEventToState(BaseEvent event);
}

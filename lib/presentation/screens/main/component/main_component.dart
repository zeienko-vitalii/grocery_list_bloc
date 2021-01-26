import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tracker_app/data/net/models/grocery_product.dart';
import 'package:list_tracker_app/presentation/base/state/base_state.dart';
import 'package:list_tracker_app/presentation/common_widgets/common_widgets.dart';
import 'package:list_tracker_app/presentation/screens/main/bloc/main_bloc.dart';

class MainComponent extends StatefulWidget {
  const MainComponent();

  @override
  _MainComponentState createState() => _MainComponentState();
}

class _MainComponentState extends BaseState<MainComponent, MainBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(GetAllGroceriesEvent());
  }

  @override
  Widget get appBar => AppBar(
        title: const Text('Grocery items'),
      );

  @override
  Widget get floatingActionButton => FloatingActionButton(
        onPressed: () async {
          final String productName = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              String newProductText;
              return AlertDialog(
                title: const Text('Add new product'),
                content: TextField(
                  onChanged: (String text) => newProductText = text,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(newProductText);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          if (productName?.isNotEmpty ?? false) {
            bloc.add(AddGroceryEvent(GroceryProduct(title: productName)));
          }
        },
        child: const Icon(Icons.add),
      );

  @override
  Widget getWidget(BuildContext context) {
    return _realtimeGroceries();
  }

  Widget _productsListView(List<GroceryProduct> items) {
    return RefreshIndicator(
      onRefresh: () async => bloc.add(GetAllGroceriesEvent()),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final GroceryProduct product = items[index];
          return _productItem(product, context);
        },
      ),
    );
  }

  Padding _productItem(GroceryProduct product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  product.title ?? '',
                ),
              ),
            ),
            IconButton(
              onPressed: () => _onItemPressed(product),
              icon: const Icon(Icons.delete, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _realtimeGroceries() {
    return StreamBuilder<List<GroceryProduct>>(
      stream: bloc.getAllItemsStream(),
      builder: (BuildContext context, AsyncSnapshot<List<GroceryProduct>> snapshot) {
        if (snapshot.hasError) {
          return error();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loaderWidget();
        }
        final List<GroceryProduct> data = snapshot.data..sort(GroceryProduct.sort);
        return (data?.isNotEmpty ?? false)
            ? _productsListView(data)
            : Container(
                child: const Center(
                  child: Text(
                    'The list is empty',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              );
      },
    );
  }

  Future<void> _onItemPressed(GroceryProduct product) async {
    final bool toRemove = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Are you sure you would like to delete ${product.title}?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('CANCEL'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (toRemove ?? false) {
      bloc.add(RemoveGroceryEvent(product));
    }
  }
}

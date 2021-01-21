import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tracker_app/presentation/appearence/styles/dimens.dart';

Widget loaderWidget() {
  return const Center(
    child: CupertinoActivityIndicator(),
  );
}

Widget error({String errorMsg}) {
  return Center(
    child: Text(
      errorMsg ?? 'Unexpected Error',
      style: TextStyle(fontSize: textSize_24, color: Colors.redAccent),
    ),
  );
}

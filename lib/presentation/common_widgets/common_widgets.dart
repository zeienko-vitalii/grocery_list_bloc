import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loaderWidget() {
  return const Center(
    child: CupertinoActivityIndicator(),
  );
}

Widget error({String errorMsg}) {
  return Center(
    child: Text(
      errorMsg ?? 'Unexpected Error',
      style: const TextStyle(fontSize: 24, color: Colors.redAccent),
    ),
  );
}

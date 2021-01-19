import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_tracker_app/presentation/appearence/styles/dimens.dart';

class Indent extends StatelessWidget {
  const Indent({Key key, this.start = 0, this.top = 0, this.end = 0, this.bottom = 0}) : super(key: key);
  final double start, top, end, bottom;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsetsDirectional.only(
          start: start?.w,
          top: top?.h,
          end: end?.w,
          bottom: bottom?.h,
        ),
      );
}

Widget loaderWidget() {
  return const Center(
    child: CupertinoActivityIndicator(),
  );
}

Widget error() {
  return Center(
    child: Text(
      'Error',
      style: TextStyle(fontSize: textSize_24),
    ),
  );
}

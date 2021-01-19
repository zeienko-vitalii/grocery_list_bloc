import 'package:flutter_screenutil/flutter_screenutil.dart';

// Text sizes
double get textSize_16 => _getAdjustedSize(16);
double get textSize_24 => _getAdjustedSize(24);

// when building textTheme data, ScreenUtil() is null
double _getAdjustedSize(double iconSize) => ScreenUtil()?.setSp(iconSize);

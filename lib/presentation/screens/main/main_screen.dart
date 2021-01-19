import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_tracker_app/utility/screen_util/screen_utils.dart';

import 'bloc/main_bloc.dart';
import 'component/main_component.dart';

class MainScreen extends StatelessWidget {
  const MainScreen();

  static const String path = '/mainScreen';

  @override
  Widget build(BuildContext context) {
    initScreenUtil(context);
    return BlocProvider<MainBloc>(
      create: (BuildContext context) => MainBloc(),
      child: const MainComponent(),
    );
  }
}

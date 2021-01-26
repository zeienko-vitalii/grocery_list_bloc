import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:list_tracker_app/presentation/screens/app/app.dart';

Future<void> main() async {
  await _init();
  runApp(GroceryApp());
}

/// Initializes Firebase
Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

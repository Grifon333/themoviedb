import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';
import 'package:themoviedb/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  final app = ScreenFactory().makeAppScreen();
  runApp(app);
}

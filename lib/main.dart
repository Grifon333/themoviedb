import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/simple_bloc_observer.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  const app = MyApp();
  runApp(app);
}

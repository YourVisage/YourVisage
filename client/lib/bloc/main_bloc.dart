import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial());
}

abstract class MainEvent {}

class CheckVersionEvent extends MainEvent {}

abstract class MainState {}

class CheckVersionSuccessState extends MainState {}

class CheckVersionFailedState extends MainState {}

class MainInitial extends MainState {}

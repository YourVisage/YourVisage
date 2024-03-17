import 'package:client/bloc/deepFakeImage/fake_bloc.dart';
import 'package:client/bloc/main_bloc.dart';
import 'package:client/bloc/authBloc.dart';
import 'package:client/bloc/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocManager {
  static final mainBloc = MainBloc();
  static final fakeBloc = FakeBloc();
  static final authBloc = AuthBloc();
  static final userBloc = UserBloc();

  static void dispose() {
    mainBloc.close();
    fakeBloc.close();
    authBloc.close();
    userBloc.close();
  }
}

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('transition$transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler();

  @override
  didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        onPaused();
        break;
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  void onResume() {}

  void onResumeDone(bool done) {}

  void onPaused() {}
}

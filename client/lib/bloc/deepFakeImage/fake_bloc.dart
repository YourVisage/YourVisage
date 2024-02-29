import 'package:client/api/api_helper.dart';
import 'package:client/api/api_manager.dart';
import 'package:client/model/fake_detect_model.dart';
import 'package:client/model/image_picker_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FakeBloc extends Bloc<FakeEvent, FakeState> {
  FakeBloc() : super(FakeInitial()) {
    on<FakeImageEvent>(_fakeSwap);
    on<DetectImageEvent>(_detectImage);
  }
}

Future<void> _fakeSwap(FakeImageEvent event, Emitter<FakeState> emit) async {
  try {
    emit(FakeLoading());
    var res = await ApiManager.swappingImage(event.request);
    if (res.code == ResponseCode.Success) {
      emit(FakeImageSuccess(response: res));
    } else if (res.code == ResponseCode.Error) {
      emit(FakeImageFailure(message: res.message ?? ''));
    }
  } catch (e) {
    emit(FakeImageFailure(message: '${e}'));
  }
}

Future<void> _detectImage(
    DetectImageEvent event, Emitter<FakeState> emit) async {
  print('res-------------------------------------');

  try {
    emit(FakeLoading());
    print('res-------------------------------------');

    var res = await ApiManager.detectImage(event.request);
    print(res);
    if (res != null) {
      // Check if the response is not null
      print('null');
      if (res.status == "success") {
        // If the status is success, emit DetectImageSuccess
        emit(DetectImageSuccess(response: res));
      } else {
        // If the status is not success, emit DetectImageFailure
        emit(DetectImageFailure(message: "Failed to detect image"));
      }
    } else {
      // If the response is null, emit DetectImageFailure
      emit(DetectImageFailure(message: "Failed to detect image"));
    }
  } catch (e) {
    emit(FakeImageFailure(message: '${e}'));
  }
}

//events
abstract class FakeEvent {}

class FakeImageEvent extends FakeEvent {
  final SwapImageRequest request;
  FakeImageEvent({required this.request});
}

class DetectImageEvent extends FakeEvent {
  final DetectModelRequest request;
  DetectImageEvent({required this.request});
}
//states

abstract class FakeState {}

class FakeLoading extends FakeState {}

class FakeImageSuccess extends FakeState {
  final SwapImageResponse response;
  FakeImageSuccess({required this.response});
}

class FakeImageFailure extends FakeState {
  final String message;
  FakeImageFailure({required this.message});
}

class DetectImageSuccess extends FakeState {
  final DetectModal response;
  DetectImageSuccess({required this.response});
}

class DetectImageFailure extends FakeState {
  final String message;
  DetectImageFailure({required this.message});
}

//initial

class FakeInitial extends FakeState {}

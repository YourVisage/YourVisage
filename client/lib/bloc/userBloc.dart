import 'package:client/api/api_helper.dart';
import 'package:client/api/api_manager.dart';
import 'package:client/model/userinfo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetUserInfoEvent>(_userInfo);
  }
  Future<void> _userInfo(GetUserInfoEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      var res = await ApiManager.userInfo(event.id);
      print(res);
      if (res.code == ResponseCode.Success) {
        emit(GetUserInfoSuccess(res: res));
      } else {
        emit(GetUserInfoFailed(message: res.message ?? ''));
      }
    } catch (e) {}
  }
}

abstract class UserEvent {}

class GetUserInfoEvent extends UserEvent {
  final String id;
  GetUserInfoEvent(this.id);
}

abstract class UserState {}

class UserLoading extends UserState {}

class CheckVersionSuccessState extends UserState {}

class CheckVersionFailedState extends UserState {}

class GetUserInfoSuccess extends UserState {
  final UserinfoResponse res;
  GetUserInfoSuccess({required this.res});
}

class GetUserInfoFailed extends UserState {
  final String message;
  GetUserInfoFailed({required this.message});
}

class UserInitial extends UserState {}

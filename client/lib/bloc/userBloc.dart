import 'package:client/api/api_helper.dart';
import 'package:client/api/api_manager.dart';
import 'package:client/model/login_model.dart';
import 'package:client/model/user_model.dart';
import 'package:client/provider/globals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(_signIn);
    on<UserLoginEvent>(_login);
    on<GetUserInfoEvent>(_userInfo);
  }

  Future<void> _signIn(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      var res = await ApiManager.register(event.request);
      print(res);
      if (res.code == ResponseCode.Success) {
        globals.sigup = res;
        emit(SignUpSuccess(res: res));
      } else {
        emit(SignUpFailed(message: res.message ?? ''));
      }
    } catch (e) {}
  }

  Future<void> _userInfo(GetUserInfoEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      var res = await ApiManager.userInfo(event.id);
      print(res);
      if (res.code == ResponseCode.Success) {
        globals.sigup = res;
        emit(SignUpSuccess(res: res));
      } else {
        emit(SignUpFailed(message: res.message ?? ''));
      }
    } catch (e) {}
  }

  Future<void> _login(UserLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      var res = await ApiManager.loginUser(event.request);
      if (res.code == ResponseCode.Success) {
        // SharedPref.setSessionToken(res.jwtToken);
        emit(LoginUserSuccess(res));
      } else if (res.code == ResponseCode.Error) {
        emit(LoginUserFailed(message: res.message ?? ''));
      }
    } catch (e) {
      emit(LoginUserFailed(message: 'error'));
    }
  }
}

abstract class AuthEvent {}

class AuthLoading extends AuthState {}

class CheckVersionEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final SignInRequest request;
  RegisterEvent({required this.request});
}

class GetUserInfoEvent extends AuthEvent {
  final String id;
  GetUserInfoEvent(this.id);
}

class UserLoginEvent extends AuthEvent {
  final LoginUserRequest request;
  UserLoginEvent({required this.request});
}

abstract class AuthState {}

class CheckVersionSuccessState extends AuthState {}

class CheckVersionFailedState extends AuthState {}

class SignUpSuccess extends AuthState {
  final SignInResponse res;
  SignUpSuccess({required this.res});
}

class SignUpFailed extends AuthState {
  final String message;
  SignUpFailed({required this.message});
}

class GetUserInfoSuccess extends AuthState {
  final SignInResponse res;
  GetUserInfoSuccess({required this.res});
}

class GetUserInfoFailed extends AuthState {
  final String message;
  GetUserInfoFailed({required this.message});
}

class LoginUserSuccess extends AuthState {
  final LoginUserResponse response;
  LoginUserSuccess(this.response);
}

class LoginUserFailed extends AuthState {
  final String message;
  LoginUserFailed({required this.message});
}

class AuthInitial extends AuthState {}

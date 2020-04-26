import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithCredential) {
       yield* _mapLoginWithCredentialToState(email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginWithCredentialToState({
    String email,
    String password
  }) async* {
    yield LoginState.loading();
    try{
      Future.delayed(Duration(seconds: 4));
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}

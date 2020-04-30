import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/bloc/authentication/authentication_bloc.dart';
import 'package:inv/bloc/authentication/authentication_event.dart';
import 'package:inv/bloc/authentication/authentication_state.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthenticationBloc _authenticationBloc;

  LoginBloc({@required AuthenticationBloc authenticationBloc}) :
    assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc;

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
      _authenticationBloc.add(LoggedIn());
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:inv/repository/user_repository.dart';
import './bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _repository;

  AuthenticationBloc({@required UserRepository repository})
      : assert(repository != null),
        _repository = repository;


  @override
  AuthenticationState get initialState => UnInitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedStated();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedStated() async* {
    yield UnAuthenticated();
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {

  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {

  }
}

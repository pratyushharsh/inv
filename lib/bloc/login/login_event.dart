import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  const Submitted({this.email, this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email, password];

  @override
  String toString() {
    // TODO: implement toString
    return 'Subitted email $email,   password $password';
  }
}
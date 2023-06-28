import 'package:equatable/equatable.dart';
import 'package:green_life_app/models/user.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadedState extends LoginState {
  LoginLoadedState(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class LoginErrorState extends LoginState {
  LoginErrorState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class LoginEmptyState extends LoginState {
  @override
  List<Object> get props => [];
}
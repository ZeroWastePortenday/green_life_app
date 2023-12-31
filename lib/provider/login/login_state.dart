import 'package:equatable/equatable.dart';
import 'package:green_life_app/models/user/api_user.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  LoginSuccessState(this.user);

  final ApiUser user;

  @override
  List<Object> get props => [user];
}

class LoginErrorState extends LoginState {
  LoginErrorState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class LoginNeedToSignUpState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginNeededState extends LoginState {
  @override
  List<Object> get props => [];
}
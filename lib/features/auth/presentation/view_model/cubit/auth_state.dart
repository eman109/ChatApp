part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class RegSuccess extends AuthState {
  String email;
  RegSuccess(this.email);
}

final class LoginSuccess extends AuthState {
  String email;
  LoginSuccess(this.email);
}

final class AuthError extends AuthState {
  String e;
  AuthError(this.e);
}

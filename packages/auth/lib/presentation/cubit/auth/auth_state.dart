import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/auth.dart';
abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];

}

class AuthEmpty extends AuthState {}
class AuthLoading extends AuthState {}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthData extends AuthState {
  final bool isLogin;
  final String? email;
  const AuthData(this.isLogin,this.email);

  @override
  List<Object?> get props => [isLogin];
}

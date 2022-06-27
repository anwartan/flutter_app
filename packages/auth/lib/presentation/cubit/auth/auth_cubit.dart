import 'package:auth/domain/get_current_user.dart';
import 'package:auth/domain/login_user.dart';
import 'package:auth/domain/logout_user.dart';
import 'package:auth/presentation/cubit/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;
  AuthCubit({required this.loginUser, required this.logoutUser, required this.getCurrentUser}) : super(AuthEmpty());

  Future<void> login(String email) async {
    emit(AuthLoading());
    final resultUser = await loginUser.execute(email);
    resultUser.fold(
          (failure) {
        emit(AuthError(failure.message));
      },
          (auth) {
        emit(AuthData(auth,email));
      },
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final resultUser = await logoutUser.execute();
    resultUser.fold(
          (failure) {
        emit(AuthError(failure.message));
      },
          (auth) {
        emit(AuthData(auth,null));
      },
    );
  }
  Future<void> isLogin() async {
    final resultUser = await getCurrentUser.execute();
    resultUser.fold(
          (failure) {
        emit(AuthError(failure.message));
      },
          (auth) {
            if(auth==null){
              emit(const AuthData(false,null));
            }else{

              emit(AuthData(true,auth.email));

            }

      },
    );
  }

}
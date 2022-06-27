import 'package:auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:auth/presentation/cubit/auth/auth_state.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000),(){
      BlocProvider.of<AuthCubit>(context, listen: false).isLogin();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthData) {
          if (state.isLogin) {
            Navigator.pushReplacementNamed(context, HOME_ROUTE);
          } else {
            Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
          }
        }
      },
      child:const Icon(Icons.movie,size: 100.0),
    )));
  }
}

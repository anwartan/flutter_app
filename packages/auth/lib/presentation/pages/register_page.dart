import 'package:auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:auth/presentation/cubit/auth/auth_state.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late OutlineInputBorder outlineInputBorder;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(buttonRadius.xs)),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Login to your account',
                      style: kHeading6,
                    ),
                    const SizedBox(
                      height: 20, // <-- SEE HERE
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                isDense: true,
                                filled: true,
                                fillColor: kOxfordBlue,
                                hintText: "Email Address",
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                border: outlineInputBorder,
                                contentPadding: const EdgeInsets.all(16),
                                isCollapsed: true),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                isDense: true,
                                filled: true,
                                fillColor: kOxfordBlue,
                                hintText: "Password",
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                border: outlineInputBorder,
                                contentPadding: const EdgeInsets.all(16),
                                isCollapsed: true),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                isDense: true,
                                filled: true,
                                fillColor: kOxfordBlue,
                                hintText: "Confirm Password",
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                border: outlineInputBorder,
                                contentPadding: const EdgeInsets.all(16),
                                isCollapsed: true),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          BlocConsumer<AuthCubit,AuthState>(
                              listener: (context, state){
                                if(state is AuthData){
                                  if(state.isLogin){
                                    Navigator.popAndPushNamed(context,HOME_ROUTE);
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("FAILED")));
                                  }
                                }
                              },
                              builder: (context,state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () {
                                    context
                                        .read<AuthCubit>()
                                        .login(emailController.text);

                                  },
                                  child: const Text("Create your account"),
                                );
                              }
                          ),

                          const SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context,LOGIN_ROUTE);
                            },
                            child: const Text(
                              "Already have an account ? ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          Divider(color: Colors.white,),
                          const SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kOxfordBlue,
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                  image: AssetImage(
                                    'assets/google.png',
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("Continue with Google", style: TextStyle(color: Colors.white),)

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kOxfordBlue,
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                  image: AssetImage(
                                    'assets/facebook.png',
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("Continue with Facebook", style: TextStyle(color: Colors.white),)

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20, // <-- SEE HERE
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kOxfordBlue,
                              minimumSize: const Size.fromHeight(50), // NEW
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                  image: AssetImage(
                                    'assets/apple.png',
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("Continue with Apple", style: TextStyle(color: Colors.white),)

                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

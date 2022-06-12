import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_programing/assets/color.dart';
import 'package:test_programing/bloc/auth_bloc.dart';
import 'package:test_programing/bloc/auth_event.dart';
import 'package:test_programing/bloc/auth_state.dart';
import 'package:test_programing/bloc/form_submission.dart';
import 'package:test_programing/pages/list.dart';
import 'package:test_programing/reposiotries/auth.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

enum statusLogin { signIn, notSignIn }

class _AuthPageState extends State<AuthPage> {
  bool _obscureText = false;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  var name, employeeId, id, isLogin;
  statusLogin _loginStatus = statusLogin.notSignIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height,
              child: BlocProvider(
                create: (context) => AuthBloc(
                  authRepository: context.read<AuthRepository>(),
                ),
                child: body(),
              ),
            ));
        break;
      case statusLogin.signIn:
        return ListPage();
        break;
    }
  }

  ///function

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getInt("id");
      employeeId = sharedPreferences.getString("number");
      var isLogin = sharedPreferences.getBool('isLogin');
      print(isLogin);
      _loginStatus =
          isLogin == true ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }

  ///widget
  Widget body() {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFaied) {
          //_showSnackBar(context, formStatus.exception.toString());

          //Future.delayed(Duration(seconds: 3));
          // ScaffoldMessenger.of(context).hideCurrentSnackBar();

        }
      },
      child: Container(
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
        child: SingleChildScrollView(
          child: Container(
            width: Get.mediaQuery.size.width,
            height: Get.mediaQuery.size.height,
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //logo
                    Container(
                      alignment: Alignment.centerLeft,
                      // height: 69,
                      width: Get.mediaQuery.size.width,

                      margin: EdgeInsets.only(left: 70, right: 55),
                      child: Image.asset(
                        'assets/images/attendit-letter-logo.png',
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    //username
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      return Container(
                        margin: EdgeInsets.only(left: 26, right: 26),
                        height: 50,
                        child: TextFormField(
                          style: TextStyle(fontFamily: "inter-medium"),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 2, left: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(width: 0, color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: baseColor, width: 2.0),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: borderColor, width: 1.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  color: textFieldColor,
                                  fontFamily: "inter-medium",
                                  fontSize: 13)),
                          onChanged: (value) => context
                              .read<AuthBloc>()
                              .add(AuthUsernameChange(value)),
                          // validator: (value) =>
                          // state.isValidPassword ? null : "password is too short",
                        ),
                      );
                    }),
                    SizedBox(
                      height: 20,
                    ),

                    //password
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      return Container(
                          margin: EdgeInsets.only(left: 26, right: 26),
                          height: 50,
                          child: TextFormField(
                            obscureText: !_obscureText,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: "inter-medium", fontSize: 13),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  iconSize: 23,
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: textFieldColor,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                contentPadding:
                                    EdgeInsets.only(top: 2, left: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(width: 0, color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: baseColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: borderColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: textFieldColor,
                                    fontFamily: "inter-medium")),
                            onChanged: (value) => context
                                .read<AuthBloc>()
                                .add(AuthPasswordChange(value)),
                            // validator: (value) =>
                            //     state.isValidUsername ? null : "username is too short",
                          ));
                    }),
                    SizedBox(
                      height: 5,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      final formStatus = state.formStatus;

                      if (formStatus is SubmissionFaied) {
                        return Container(
                            margin:
                                EdgeInsets.only(left: 26, right: 26, top: 10),
                            child: Container(
                              width: double.infinity - 20,
                              height: 40,
                              decoration: new BoxDecoration(
                                color: redColorOpacity,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset(
                                          "assets/images/alert-circle.png"),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text(
                                        "${formStatus.exception.toString()}",
                                        style: TextStyle(
                                            color: redColor,
                                            fontFamily: "inter-regular",
                                            fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }
                      return Container();
                    }),

                    SizedBox(
                      height: 40,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      return state.formStatus is FormSubmitting
                          ? CircularProgressIndicator(
                              color: baseColor,
                            )
                          : Container(
                              width: Get.mediaQuery.size.width,
                              margin: EdgeInsets.only(left: 26, right: 26),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: _loading
                                      ? null
                                      : () {
                                          //Get.to(Na)
                                          // Get.to(Nav());

                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<AuthBloc>(context)
                                                .add(AuthSubmitted());
                                            // context
                                            //     .read<AuthBloc>()
                                            //     .add(AuthSubmitted());
                                          }
                                        },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(baseColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )),
                                  ),
                                  child: _loading
                                      ? Container(
                                          width: 30,
                                          height: 30,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )))
                                      : Text(
                                          "Sign In",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "inter-semi-bold"),
                                        )),
                            );
                    }),

                    //fogot password
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                            "Lupa Password? ",
                            style: TextStyle(
                                color: textFieldColor,
                                fontFamily: "inter-medium"),
                          )),
                          InkWell(
                            onTap: () {
                              // Get.toNamed(Routes.recoveryPassword);
                            },
                            child: Container(
                                child: Text(
                              " Pulihkan disini",
                              style: TextStyle(
                                  color: baseColor,
                                  fontFamily: "inter-mediumx"),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

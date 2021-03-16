import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:female_in_action/Screen/home_screen.dart';
import 'package:female_in_action/Screen/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppSignIn extends StatefulWidget {
  @override
  _AppSignInState createState() => _AppSignInState();
}

class _AppSignInState extends State<AppSignIn> {
  /*  DatabaseHelper db = new DatabaseHelper();
  ModelUser items;
 */
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_authBloc = BlocProvider.of<AuthBloc>(context); //init bloc
    //_authBloc.add(CheckLoginEvent());
    //_authBloc.add(ClearEvent());
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    TextEditingController _textEditingEmail = TextEditingController();
    TextEditingController _textEditingPassword = TextEditingController();
    final _formKey = GlobalKey<FormState>(); // key vallidation form

    //firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
      backgroundColor: Color(0xFFF9E5EE),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 250,
                      height: 250,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Maaf data tidak boleh kosong';
                        } else if (EmailValidator.validate(value) == false) {
                          return 'Maaf format email salah';
                        }
                        return null;
                      },
                      controller: _textEditingEmail,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.pink),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Maaf data tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: _textEditingPassword,
                      obscureText: true,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.pink),
                        ),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                        ),
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.all(17.0),
                        onPressed: () async {
                          //dihapus dulu blom perlu
                          if (_formKey.currentState.validate()) {
                            EasyLoading.show(status: 'loading...');
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _textEditingEmail.text,
                                    password: _textEditingPassword.text)
                                .then((currentUser) => users
                                        .doc(currentUser.user.uid)
                                        .get()
                                        .then((DocumentSnapshot result) {
                                      EasyLoading.dismiss();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyHomePage(
                                                    uid: currentUser.user.uid,
                                                    uavatarUrl:
                                                        result['uavatarUrl'],
                                                    username:
                                                        result['username'],
                                                  )),
                                          (route) => false);
                                    }).catchError((error) {
                                      var errorCode = error.code;
                                      var errorMessage = error.message;
                                      // [START_EXCLUDE]
                                      if (errorCode == 'auth/weak-password') {
                                      } else if (errorMessage ==
                                          "The email address is already in use by another account.") {
                                        EasyLoading.showError(
                                            "Email sudah digunakan!");
                                        //alert(errorMessage);
                                      } else {
                                        print(error);
                                        EasyLoading.showError(
                                            "Email atau password tidak ditemukan!");
                                      }
                                    }))
                                .catchError((error) {
                              var errorCode = error.code;
                              var errorMessage = error.message;
                              // [START_EXCLUDE]
                              if (errorCode == 'auth/weak-password') {
                              } else if (errorMessage ==
                                  "The email address is already in use by another account.") {
                                EasyLoading.showError("Email sudah digunakan!");
                                //alert(errorMessage);
                              } else {
                                print(error);
                                EasyLoading.showError(
                                    "Email atau password tidak ditemukan!");
                              }
                            });
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins-Medium.ttf',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.purple)),
                      ),
                      /*  }), */
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppSingUp()),
                          )
                        },
                        child: Container(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFFAC252B),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';

class AppSingUp extends StatefulWidget {
  @override
  _AppSingUpState createState() => _AppSingUpState();
}

class _AppSingUpState extends State<AppSingUp> {
  int selectedRadio = 1;
  String gender = "laki-laki";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    TextEditingController _textEditingUsername = TextEditingController();
    TextEditingController _textEditingEmail = TextEditingController();
    TextEditingController _textEditingGender = TextEditingController();
    TextEditingController _textEditingPassword = TextEditingController();
    TextEditingController _textEditingPassword2 = TextEditingController();
    TextEditingController _textEditingFullName = TextEditingController();
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
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/logo.jpg",
                        fit: BoxFit.fitWidth,
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
                      controller: _textEditingUsername,
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
                        hintText: "Username",
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
                      controller: _textEditingFullName,
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
                        hintText: "Nama Lengkap",
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
                          Icons.mail,
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
                      controller: _textEditingGender,
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
                          FontAwesomeIcons.venusMars,
                          color: Color(0xFF666666),
                          size: defaultIconSize,
                        ),
                        fillColor: Color(0xFFF2F3F5),
                        hintStyle: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize),
                        hintText: "Jenis kelamin",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Maaf data tidak boleh kosong';
                              } else if (value.length < 6) {
                                return 'Password harus lebih dari 6 karakter';
                              }
                              return null;
                            },
                            controller: _textEditingPassword,
                            obscureText: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 2,
                                    style: BorderStyle.solid,
                                    color: Colors.pink),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: "Password",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Maaf data tidak boleh kosong';
                              } else if (value != _textEditingPassword.text) {
                                return 'Password tidak sama';
                              }
                              return null;
                            },
                            controller: _textEditingPassword2,
                            obscureText: true,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 2,
                                    style: BorderStyle.solid,
                                    color: Colors.pink),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                              ),
                              hintText: "Konfirmasi Password",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 55,
                      child: RaisedButton(
                        padding: EdgeInsets.all(17.0),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            EasyLoading.show(status: 'loading...');
                            checkInternet();
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _textEditingEmail.text,
                                    password: _textEditingPassword2.text)
                                .then((currentUser) =>
                                    users.doc(currentUser.user.uid).set({
                                      'id': currentUser.user.uid,
                                      'username': _textEditingUsername.text,
                                      'email': _textEditingEmail.text,
                                      'gender': _textEditingGender.text,
                                      'password': _textEditingPassword2.text,
                                      'uavatarUrl': null,
                                      'bio': null,
                                      'name': _textEditingFullName.text,
                                    }).then((result) {
                                      print("sukses!!!");
                                      EasyLoading.dismiss();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AppSignIn()),
                                      );
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
                              }
                            });
                          }
                        },
                        child: Text(
                          "Sign Up",
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
                          "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppSignIn()),
                          );
                        },
                        child: Container(
                          child: Text(
                            "Sign In",
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

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else
    EasyLoading.showError("Terjadi Kesalahan atau Cek Internet Anda!!!");
  return false;
}

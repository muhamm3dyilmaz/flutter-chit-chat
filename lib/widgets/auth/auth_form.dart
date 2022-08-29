import 'dart:io';
import 'package:flutter/material.dart';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFunc,
    this.isLoading,
  );

  final bool isLoading;

  final void Function(
    String email,
    String userName,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFunc;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile = File('');

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (_userImageFile == null /*|| _userImageFile.path.isEmpty*/ &&
        !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Colors.black54,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState?.save();
      widget.submitFunc(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 105),
        child: Column(
          children: <Widget>[
            Text(
              "Chit Chat",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
                fontFamily: 'Pacifico',
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.4,
                    0.9,
                  ],
                  colors: [
                    Colors.black87,
                    Colors.black38,
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (!_isLogin) UserImagePicker(_pickedImage),
                      TextFormField(
                        key: ValueKey('e-mail'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid e-mail address.';
                          }
                          return null;
                        },
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'e-mail',
                          labelStyle: TextStyle(
                            color: Colors.teal,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          _userEmail = value;
                        },
                      ),
                      SizedBox(height: 15),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 4) {
                              return 'Please enter least 4 characters.';
                            }
                            return null;
                          },
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                            labelText: 'username',
                            labelStyle: TextStyle(
                              color: Colors.teal,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.teal,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      SizedBox(height: 15),
                      TextFormField(
                        key: ValueKey('password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return 'Please enter least 6 characters.';
                          }
                          return null;
                        },
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: TextStyle(
                            color: Colors.teal,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          _userPassword = value;
                        },
                      ),
                      SizedBox(height: 15),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: RaisedButton(
                            onPressed: _trySubmit,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: [
                                    0.1,
                                    0.4,
                                    0.6,
                                    0.9,
                                  ],
                                  colors: [
                                    Colors.yellow,
                                    Colors.red,
                                    Colors.indigo,
                                    Colors.teal,
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              child: Container(
                                // constraints: const BoxConstraints(
                                //     minWidth: 10.0,
                                //     minHeight: 36.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: Text(
                                  _isLogin ? 'Login' : 'Signup',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (!widget.isLoading)
                        FlatButton(
                          child: Text(
                            _isLogin ? 'Register' : 'Already Have an Account',
                          ),
                          textColor: Colors.teal,
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/pages/LoginPage.dart';
import 'package:sizer/sizer.dart';
import 'package:email_validator/email_validator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register to shopping app',
      home: MyRegPage(title: 'Register to shopping app'),
    );
  }
}

class MyRegPage extends StatefulWidget {
  MyRegPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyRegPageState createState() => _MyRegPageState();
}

class _MyRegPageState extends State<MyRegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          children: <Widget>[_RegisterEmailSection()],
        );
      }),
    );
  }
}

class _RegisterEmailSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterEmailSectionState();
}

class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  final String title = 'Registration';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _userEmail = '';

  @override
  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _userEmail = user.email!;
      });
    } else {
      setState(() {
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 90.w,
      child: Scaffold(
        appBar: null,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (String? value) {
                  if (!EmailValidator.validate(value!)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _register();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                      Fluttertoast.showToast(msg: "Registered successfully");
                    }
                    else{
                      Fluttertoast.showToast(msg: "Registration failed");
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}



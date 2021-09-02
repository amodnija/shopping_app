import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:sizer/sizer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Shopping App',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          children: <Widget>[_EmailPasswordForm()],
        );
      }),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool success = false;

  void _signInWithEmailAndPassword() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      setState(() {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: HomeScreen(),
              inheritTheme: true,
              ctx: context),
        );
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Login failed, check credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Text('Login to shopping app',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45))),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Image(
                image: AssetImage('lib/assets/logo.png'),
                fit: BoxFit.contain,
                width: 60.w,
                height: 30.h,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String? value) {
                if (!EmailValidator.validate(value!)) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _signInWithEmailAndPassword();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
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

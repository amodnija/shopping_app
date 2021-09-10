import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/pages/LoginPage.dart';
import 'package:sizer/sizer.dart';
import 'package:email_validator/email_validator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyRegPage(),
    );
  }
}

class MyRegPage extends StatefulWidget {
  MyRegPage({Key? key}) : super(key: key);

  @override
  _MyRegPageState createState() => _MyRegPageState();
}

class _MyRegPageState extends State<MyRegPage> {
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
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: 99.h,
      width: 99.w,
      child: Scaffold(
        appBar: null,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Center(
                    child: Text('Register for shopping app',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54))),
              ),
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
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _register();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: LoginScreen(),
                                inheritTheme: true,
                                ctx: context),
                          );
                          Fluttertoast.showToast(
                              msg: "Registered successfully");
                        } else {
                          Fluttertoast.showToast(msg: "Registration failed");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Register',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Already a member?',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: LoginScreen(),
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            const Text('Login', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
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

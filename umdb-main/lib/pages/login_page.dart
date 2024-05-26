import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umdb/pages/dashboard_page.dart';
import 'package:umdb/pages/home_page.dart';

class LoginPage  extends StatelessWidget {
  const LoginPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("login"),),
      body: const LoginForm() ,
    );
  }
}

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController() ;
  final _passwordController = TextEditingController();

  _saveAuthCredentials(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    final isAuthStored = await prefs.setBool('isAuth', value);

    if (isAuthStored) {
      //checking for login page is visible or not 
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const DashboardPage();
          }),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(32),
  child : Form(
    key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          label: Text('Username'),
        ),
        validator: (value){
          if(value != null){

            // REGEX EXPRESSION
            // final bool emailValid =
            // RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            //     .hasMatch(value);

          if (value.length > 6){
            return null;
          }
    }
          return 'Username should be at  least 6 Characters';
        },
        ),
        TextFormField(
          controller: _passwordController,
        decoration: const InputDecoration(
        label: Text("Password")
    ),
          validator: (value){
            if(value != null){
              if (value.length > 6){
                return null;
              }
            }
            return 'Password should be at  least 6 Characters';
          },
        ),
        const SizedBox(height: 16,),
        ElevatedButton(onPressed:() {
          final isValid = _formKey.currentState?.validate();
          print('valid = $isValid');
          if(isValid ?? false) {
            //save the isAuth value to sharedpreference

            _saveAuthCredentials(isValid!);

          }
    },
          child: const Text("Login"),
        ),

    ],
  ),
  ),
  );throw UnimplementedError();
  }
}
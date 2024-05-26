import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umdb/pages/dashboard_page.dart';
import 'package:umdb/pages/home_page.dart';
import 'package:umdb/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _checkIfAuthenticate() async{
    final prefs = await SharedPreferences.getInstance();
    final isAuthenticated = prefs.getBool('isAuth');
    if(mounted){
      if (isAuthenticated ?? false){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),);
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed( const Duration(seconds:2),()=>_checkIfAuthenticate());
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umdb/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<bool> _deleteAuthKey() async {
    final prefs = await SharedPreferences.getInstance();
    final isKeyDeleted = prefs.remove('isAuth');
    return isKeyDeleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: [
              Expanded( // expanded should be a direct colum of Row or Column
                child: ElevatedButton(
                  onPressed: () async {
                    final isDeleted = await _deleteAuthKey();
                    if (isDeleted && context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage(), ),
                      );
                    }
                  },
                  child: const Text("LogOut"),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

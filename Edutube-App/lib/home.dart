// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/firebase_auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).currentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Container(
            child: Text("Home page"),
          ),
          Text(user!.email ?? ''),
          Text(user.displayName ?? ''),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  FirebaseAuthService().signOutUser().then((result) {
                    Navigator.pushNamed(context, '/onboard');
                  });
                });
              },
              child: Text("logout"))
        ],
      ),
    );
  }
}

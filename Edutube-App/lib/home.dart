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
        title: Text("EduKit"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text("Dark Coders"),
                accountEmail: Text("Dark@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg"
                  ),
                )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(Icons.add_sharp),
              title: Text("Add Playlist"),
            ),
            ListTile(
              leading: Icon(Icons.featured_play_list_outlined),
              title: Text("My Playlist"),
            ),
            ListTile(
              leading: Icon(Icons.account_box_outlined),
              title: Text("About Us"),
            ),
            ListTile(
              leading: Icon(Icons.contact_support_outlined),
              title: Text("Contact Us"),
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {

                  setState(() {

                    FirebaseAuthService().signOutUser().then((result){
                      Navigator.pushNamed(context, '/Splashview');
                    });

                  });
              },
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authentication/firebase_auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user1 => _auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.my_profile,
        ),
      ),
      body: Stack(children: <Widget>[
        ClipPath(
          child: Container(color: Theme.of(context).primaryColor),
          clipper: GetClipper(),
        ),
        Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                child: Column(children: [
                  user1.photoURL != null
                      ? ClipOval(
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              image: user1.photoURL != null
                                  ? DecorationImage(
                                      image: NetworkImage(user1.photoURL!),
                                      fit: BoxFit.cover)
                                  : null,
                              boxShadow: [
                                BoxShadow(blurRadius: 20.0, color: Colors.white)
                              ],
                            ),
                          ),
                        )
                      : ClipOval(
                          child: Material(
                            // color: CustomColors.firebaseGrey.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.black54),
                      Text(
                        " " + user1.displayName,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                    child: SizedBox(
                      height: 1.0,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.black54),
                      Text(
                        " " + user1.email,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 90.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Text(
                        AppLocalizations.of(context)!.logout,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        setState(() {
                          FirebaseAuthService().signOutUser().then((result) {
                            Navigator.pushNamed(context, '/Splashview');
                          });
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      AppLocalizations.of(context)!.logout_txt,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ])))
      ]),
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 4);
    path.lineTo(size.width + 200, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

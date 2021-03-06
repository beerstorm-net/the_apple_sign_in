import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import 'sign_in_page.dart';

class SecretMembersOnlyPage extends StatelessWidget {
  final AppleIdCredential credential;

  const SecretMembersOnlyPage({@required this.credential});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('🏴‍☠️ SECRET PIRATE CLUB 🏴‍☠️'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to the secret pirate club, ${credential.fullName?.givenName}!",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "I have your email as '${credential.email}'",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                OutlinedButton(
                    child: Text("Log out"),
                    onPressed: () async {
                      await FlutterSecureStorage().deleteAll();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SignInPage()));
                    })
              ]),
        )));
  }
}

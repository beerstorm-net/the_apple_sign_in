import 'package:before_after/before_after.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' as TheAppleSignIn;

import 'native_button.dart';

class ButtonTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In with Apple Example App'),
      ),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 320,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonComparison(
                  style: TheAppleSignIn.ButtonStyle.whiteOutline,
                  type: TheAppleSignIn.ButtonType.signIn,
                ),
                ButtonComparison(
                  style: TheAppleSignIn.ButtonStyle.black,
                  type: TheAppleSignIn.ButtonType.signIn,
                ),
                ButtonComparison(
                  style: TheAppleSignIn.ButtonStyle.white,
                  type: TheAppleSignIn.ButtonType.signIn,
                ),
                ButtonComparison(
                  style: TheAppleSignIn.ButtonStyle.whiteOutline,
                  type: TheAppleSignIn.ButtonType.continueButton,
                ),
                ButtonComparison(
                  style: TheAppleSignIn.ButtonStyle.black,
                  type: TheAppleSignIn.ButtonType.continueButton,
                ),
                ButtonComparison(
                  style: TheAppleSignIn.ButtonStyle.white,
                  type: TheAppleSignIn.ButtonType.continueButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonComparison extends StatelessWidget {
  final TheAppleSignIn.ButtonStyle style;
  final TheAppleSignIn.ButtonType type;

  ButtonComparison({@required this.style, @required this.type});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            // Text('Native'),
            // SizedBox(
            //   height: 5,
            // ),
            // NativeAppleSignInButton(
            //   style: style,
            //   type: type,
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text('Flutter'),
            // SizedBox(
            //   height: 5,
            // ),
            // AppleSignInButton(
            //   style: style,
            //   type: type,
            // ),
            Text('Native / Flutter'),
            BeforeAfter(
              imageCornerRadius: 0,
              thumbColor: Colors.blue,
              beforeImage: NativeAppleSignInButton(
                style: style,
                type: type,
              ),
              afterImage: TheAppleSignIn.AppleSignInButton(
                style: style,
                type: type,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

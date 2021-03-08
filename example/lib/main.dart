import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import 'button_test/button_test_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignInPage());
  }
}

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Future<bool> _isAvailableFuture = TheAppleSignIn.isAvailable();

  String errorMessage;

  @override
  void initState() {
    super.initState();
    checkLoggedInState();

    TheAppleSignIn.onCredentialRevoked.listen((_) {
      print("Credentials revoked");
    });
  }

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
                  width: 280,
                  child: FutureBuilder<bool>(
                    future: _isAvailableFuture,
                    builder: (context, isAvailableSnapshot) {
                      if (!isAvailableSnapshot.hasData) {
                        return Container(child: Text('Loading...'));
                      }

                      return isAvailableSnapshot.data
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  AppleSignInButton(
                                    onPressed: logIn,
                                  ),
                                  if (errorMessage != null) Text(errorMessage),
                                  SizedBox(
                                    height: 200,
                                  ),
                                  ElevatedButton(
                                    child: Text("Button Test Page"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ButtonTestPage()));
                                    },
                                  )
                                ])
                          : Text(
                              'Sign in With Apple not available. Must be run on iOS 13+');
                    },
                  )))),
    );
  }

  void logIn() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:

        // Store user ID
        await FlutterSecureStorage()
            .write(key: "userId", value: result.credential.user);

        // Navigate to secret page (shhh!)
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => AfterLoginPage(credential: result.credential)));
        break;

      case AuthorizationStatus.error:
        print("Sign in failed: ${result.error.localizedDescription}");
        setState(() {
          errorMessage = "Sign in failed";
        });
        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
  }

  void checkLoggedInState() async {
    final userId = await FlutterSecureStorage().read(key: "userId");
    if (userId == null) {
      print("No stored user ID");
      return;
    }

    final credentialState = await TheAppleSignIn.getCredentialState(userId);
    switch (credentialState.status) {
      case CredentialStatus.authorized:
        print("getCredentialState returned authorized");
        break;

      case CredentialStatus.error:
        print(
            "getCredentialState returned an error: ${credentialState.error.localizedDescription}");
        break;

      case CredentialStatus.revoked:
        print("getCredentialState returned revoked");
        break;

      case CredentialStatus.notFound:
        print("getCredentialState returned not found");
        break;

      case CredentialStatus.transferred:
        print("getCredentialState returned not transferred");
        break;
    }
  }
}

class AfterLoginPage extends StatelessWidget {
  final AppleIdCredential credential;

  const AfterLoginPage({@required this.credential});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Logged in Success️'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome ${credential.fullName?.givenName}!",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Your email: '${credential.email}'",
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

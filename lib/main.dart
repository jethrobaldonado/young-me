import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';
import 'widgets/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      throw('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      initialStep: AuthenticatorStep.signIn,
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Young Me - Baby Book', style: TextStyle(
              color: Colors.deepOrange
            )),
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
            foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout of the App',
                onPressed: () {
                 signOutCurrentUser();
                },
              ),
            ],
          ),
          body: const Center(
            child: Text('Logged IN!'),
          ),
        ),
      ),
    );
  }
}
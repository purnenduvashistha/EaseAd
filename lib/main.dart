import 'package:easy_admission/views/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'themes.dart';
import 'views/login.dart';
import 'views/register.dart';
import '../services/auth.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kStatusBarColor,
      statusBarIconBrightness: kStatusBarIconBrightness));
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text('An Unexpected Error occured! :(')));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return Center(
            child: Container(
                height: 100, width: 100, child: CircularProgressIndicator()));
      },
    );
  }
}

class MyApp extends StatelessWidget {
  final _firebaseAuthUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final _auth = Auth(firebaseAuth: _firebaseAuthUser);
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (context) => _auth,
        ),
          /*TODO: build tab views for bottom navigation bar*/
         // ChangeNotifierProvider<TabViews>(
         //   create: (context) => TabViews(),
         // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
        routes: {

          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),


        },
      ),
    );
  }
}

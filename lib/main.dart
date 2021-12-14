import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ocean_administration/Login_Signup/login_page.dart';
import 'package:ocean_administration/Login_Signup/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh', 'CN'),
      ],

      theme: ThemeData(

        primaryColor: Colors.blue[800]
      ),
      debugShowCheckedModeBanner: false,
      home: WelPage(),
    );
  }
}

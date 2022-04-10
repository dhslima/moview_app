import 'package:moview_app/pages/moview_add.dart';
import 'package:moview_app/pages/moview_details.dart';
import 'package:moview_app/pages/moview_edit.dart';
import 'package:flutter/material.dart';
import 'pages/moview_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MoviewPage(),
        '/add': (context) => MoviewAddPage(),
        '/edit': (context) => MoviewEditPage(),
        '/details': (context) => MoviewDetailsPage()
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("pt"),
      ],
    );
  }
}
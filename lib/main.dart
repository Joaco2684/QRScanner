import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/pages/create_page.dart';
import 'package:qr_app/pages/home_page.dart';
import 'package:qr_app/pages/mapa_page.dart';
import 'package:qr_app/providers/scan_list_provider.dart';
import 'package:qr_app/providers/ui_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider() ),
        ChangeNotifierProvider(create: (_) => new ScanListProvider() ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'mapa': (BuildContext context) => MapaPage(),
          'crear': (BuildContext context) => CreateQr(),
        },
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          ),
          primarySwatch: Colors.deepPurple
        ),
      ),
    );
  }
}
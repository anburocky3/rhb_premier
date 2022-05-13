import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:rhb_premier/App/config.dart';
import 'package:rhb_premier/Routes/routes.dart';
import 'package:rhb_premier/Theme/style.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';
import 'package:rhb_premier/providers/TransactionProvider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization(); // delay splash screen
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<TransactionProvider>(
                create: (context) => TransactionProvider(authProvider)),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Config.APP_NAME,
            theme: appTheme,
            routes: PageRoutes().routes(),
          ),
        );
      }),
    );
  }
}

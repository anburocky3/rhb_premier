import 'dart:async';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhb_premier/Components/custom_button.dart';
import 'package:rhb_premier/Components/entry_field.dart';
import 'package:rhb_premier/Routes/routes.dart';
import 'package:rhb_premier/helpers/PageLoader.dart';
import 'package:rhb_premier/helpers/global.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';
import 'package:rhb_premier/widgets/alert.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController(text: 'rajini@gmail.com');
  final passwordController = TextEditingController(text: '123456789');

  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  late String deviceName;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getDeviceName();
  }

  Future<void> getDeviceName() async {
    try {
      deviceName = await GlobalHelper().getDeviceName();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadedSlideAnimation(
        ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(20)), //add
                  Image(image: AssetImage('assets/logo.png'), width: 180),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Sign in',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            AlertComponent(type: AlertType.error, msg: errorMessage),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    child: EntryField(
                      hint: 'email@you.com',
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (dynamic value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: EntryField(
                      hint: 'Password',
                      textInputType: TextInputType.text,
                      obscureText: true,
                      controller: passwordController,
                      validator: (dynamic value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    child: CustomButton(
                      label: 'Sign in',
                      onTap: () => doLogin(),
                      icon: Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Future<void> doLogin() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);

    final loader = PageLoader(context);

    try {
      loader.init();

      await provider.login(
          emailController.text, passwordController.text, deviceName);

      loader.complete();

      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => VerificationPage(email: emailController.text)));
      Navigator.of(context).pushNamed(PageRoutes.securityCode, arguments: emailController.text);
    } catch (exception) {
      setState(() {
        errorMessage = exception.toString().replaceAll('Exception: ', '');
      });

      loader.complete();
    }
  }
}

import 'dart:async';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rhb_premier/Components/custom_button.dart';
import 'package:rhb_premier/Components/entry_field.dart';
import 'package:rhb_premier/Routes/routes.dart';
import 'package:rhb_premier/helpers/PageLoader.dart';
import 'package:rhb_premier/helpers/global.dart';
import 'package:rhb_premier/providers/AuthProvider.dart';
import 'package:rhb_premier/widgets/alert.dart';

class VerificationPage extends StatefulWidget {
  final email;

  VerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final securityCodeController = TextEditingController();


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
      appBar: AppBar(
        elevation: 0,
        title: Text('Security Code'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Enter your security code here',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AlertComponent(
                    type: AlertType.error,
                    msg: errorMessage,
                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: EntryField(
                      controller: securityCodeController,
                      hint: 'Enter Your Security code',
                      textInputType:
                          TextInputType.numberWithOptions(decimal: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      prefixIcon: Icons.code,
                      textStyle: TextStyle(fontSize: 20),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter security code';
                        }
                        if (value!.length != 4) {
                          return 'The security code must be 4 digits.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
                    child: CustomButton(
                        label: 'Verify', onTap: () => checkSecurityCode()),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text('Get your security code from your Bank.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  Spacer(
                    flex: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Future<void> checkSecurityCode() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);

    final loader = PageLoader(context);

    try {
      loader.init();

      await provider.validateSecurityCode(
          widget.email, securityCodeController.text, deviceName);

      // context.showSuccessBar(
      //     content: Text('Authentication verified!'));

      Navigator.of(context).pushReplacementNamed(PageRoutes.homePage);

      loader.complete();
    } catch (exception) {
      print('exception: ${exception.toString()}');
      setState(() {
        errorMessage = exception.toString().replaceAll('Exception: ', '');
      });
      loader.complete();
    }
  }
}

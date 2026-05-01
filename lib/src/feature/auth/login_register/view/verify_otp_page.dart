import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:stockmanagement/src/feature/app/app_page.dart';
import 'package:stockmanagement/src/feature/home/view/home_page.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  Timer? _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,

    textStyle: TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey.shade200,
    ),
  );

  PinTheme get focusedPinTheme => defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(20),
  );

  PinTheme get errorPinTheme => defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Color.fromRGBO(255, 0, 0, 1)),
    borderRadius: BorderRadius.circular(20),
  );

  PinTheme get submittedPinTheme => defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ManageX",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
                Text(
                  "Indentify Verification",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            Text(
              "We sent a secure code to your registered email address. Please enter the code below to access the store",
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.hintColor,
              ),
              textAlign: TextAlign.center,
            ),

            buildPinPut(theme),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _secondsRemaining == 0
                    ? TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.refresh, color: theme.hintColor),
                        label: Text(
                          "Resend Code",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      )
                    : _secondsRemaining == 0
                    ? Text(
                        "Resend Code",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.hintColor,
                        ),
                      )
                    : Text(
                        "Expires in ${_secondsRemaining} seconds",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPinPut(ThemeData theme) {
    return Pinput(
      onCompleted: (pin) => verfiyPin(),
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      mainAxisAlignment: MainAxisAlignment.center,
      textInputAction: TextInputAction.done,
      crossAxisAlignment: CrossAxisAlignment.center,
      validator: (s) {
        return s == '2222' ? null : 'Pin is incorrect';
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
    );
  }

  void verfiyPin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AppPage()),
    );
  }
}

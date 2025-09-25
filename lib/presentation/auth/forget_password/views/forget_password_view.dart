import 'package:elevate_tracking_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            Text(AppLocalizations.of(context).password),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05 * width),
        child: Column(
          children: [
            SizedBox(height: 0.05 * height),
            Center(
              child: Text(
                AppLocalizations.of(context).forgetPassword,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 0.02 * height),
            Center(
              child: Text(
                "Please enter your email associated to ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 0.005 * height),
            Center(
              child: Text(
                "your account",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 0.05 * height),
            TextFormField(
              
               initialValue: "email",
            )


          ],
        ),
      ),
    );
  }
}

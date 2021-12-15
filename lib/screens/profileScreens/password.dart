import 'package:ecommerce_flutter/provider/profile_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordSreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, pp, child) => Column(
        children: [
          Text(
            'Change Password',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          Form(
            key: formKey,
            child: Column(
              children: [
                defaultFormField(
                  label: 'Current Password',
                  prefix: Icons.lock_outline,
                  isObscure: true,
                  controller: pp.currPassword,
                  validatorMsg: 'Please your valid password',
                ),
                SizedBox(height: 30),
                defaultFormField(
                  label: 'New Password',
                  prefix: Icons.lock_outline,
                  isObscure: true,
                  controller: pp.newPasssword,
                  validatorMsg: 'Please enter a valid password',
                ),
                SizedBox(height: 30),
                defaultButton(
                  label: 'Save',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      pp.changePassword(context);
                    }
                  },
                ),
                SizedBox(height: 30),
                Text(
                  pp.passError,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

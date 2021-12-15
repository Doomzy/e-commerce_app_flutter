import 'package:ecommerce_flutter/provider/profile_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenInfoScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, pp, child) => Column(
        children: [
          Text(
            'Edit Profile',
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
                  label: 'Name',
                  prefix: Icons.person,
                  isObscure: false,
                  controller: pp.profileName,
                  validatorMsg: 'Please enter a valid name',
                ),
                SizedBox(height: 30),
                defaultFormField(
                  label: 'E-mail',
                  prefix: Icons.email_rounded,
                  isObscure: false,
                  controller: pp.profileEmail,
                  validatorMsg: 'Please enter a valid email',
                ),
                SizedBox(height: 30),
                defaultFormField(
                  label: 'Phone',
                  prefix: Icons.phone_android_rounded,
                  isObscure: false,
                  controller: pp.profilePhone,
                  validatorMsg: 'Please enter a valid phone number',
                ),
                SizedBox(height: 30),
                defaultButton(
                  label: 'Save',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      pp.updateUser(context);
                    }
                  },
                ),
                SizedBox(height: 30),
                Text(
                  pp.genError,
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

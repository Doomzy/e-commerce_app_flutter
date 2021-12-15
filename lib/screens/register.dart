import 'package:ecommerce_flutter/provider/register_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsDirectional.all(20.0),
        child: SingleChildScrollView(
          child: Consumer<RegisterProvider>(
            builder: (context, rp, child) => Column(
              children: [
                Text(
                  'Register',
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
                        controller: rp.registerName,
                        validatorMsg: 'Please enter a valid name',
                      ),
                      SizedBox(height: 30),
                      defaultFormField(
                        label: 'E-mail',
                        prefix: Icons.email_rounded,
                        isObscure: false,
                        controller: rp.registerEmail,
                        validatorMsg: 'Please enter a valid email',
                      ),
                      SizedBox(height: 30),
                      defaultFormField(
                        label: 'Phone',
                        prefix: Icons.phone_android_rounded,
                        isObscure: false,
                        controller: rp.registerPhone,
                        validatorMsg: 'Please enter a valid phone number',
                      ),
                      SizedBox(height: 30),
                      defaultFormField(
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: rp.passwordVisiblity,
                        suffixOnPressed: () {
                          rp.togglePassword();
                        },
                        isObscure: rp.obscurePassword,
                        controller: rp.registerPass,
                        validatorMsg: 'Please enter a valid password',
                      ),
                      SizedBox(height: 30),
                      rp.gettingData
                          ? Center(child: CircularProgressIndicator())
                          : defaultButton(
                              label: 'Create',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  rp.register(context);
                                }
                              },
                            ),
                      SizedBox(height: 30),
                      Text(
                        rp.registerError,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

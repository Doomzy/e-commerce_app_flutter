import 'package:ecommerce_flutter/provider/login_provider.dart';
import 'package:ecommerce_flutter/screens/register.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, lp, child) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 30.0, end: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'login now to enjoy our hot offers!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey[500], fontSize: 18.0),
                  ),
                  SizedBox(height: 40.0),
                  Form(
                    key: loginFormKey,
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: emailController,
                          label: 'E-mail',
                          prefix: Icons.email_outlined,
                          isObscure: false,
                          validatorMsg: 'please enter your e-mail',
                        ),
                        SizedBox(height: 30.0),
                        defaultFormField(
                            controller: passwordController,
                            label: 'password',
                            prefix: Icons.lock_outlined,
                            isObscure: lp.obscurePassword,
                            suffix: lp.passwordVisiblity,
                            suffixOnPressed: () {
                              lp.togglePassword();
                            },
                            validatorMsg: 'password is too short'),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsetsDirectional.only(
                              top: 40.0, bottom: 15.0),
                          child: lp.gettingData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : defaultButton(
                                  label: 'LOGIN',
                                  onPressed: () {
                                    if (loginFormKey.currentState!.validate()) {
                                      lp.login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        myContext: context,
                                      );
                                    }
                                  }),
                        ),
                        Text(lp.loginError,
                            style: TextStyle(color: Colors.red)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              ),
                              child: Text('Register now'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ecommerce_flutter/provider/profile_provider.dart';
import 'package:ecommerce_flutter/screens/profileScreens/profile_edit.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, pp, child) => pp.userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsetsDirectional.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.portrait_rounded,
                    size: 120.0,
                  ),
                  SizedBox(height: 60.0),
                  profileFields(
                    fieldLabel: 'Name',
                    fieldData: pp.userData!.name.toString(),
                  ),
                  Divider(),
                  SizedBox(height: 30.0),
                  profileFields(
                    fieldLabel: 'E-mail',
                    fieldData: pp.userData!.email.toString(),
                  ),
                  Divider(),
                  SizedBox(height: 30.0),
                  profileFields(
                    fieldLabel: 'Phone',
                    fieldData: pp.userData!.phone.toString(),
                  ),
                  SizedBox(height: 50.0),
                  defaultButton(
                      label: 'EDIT',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEditScreen()),
                        );
                      }),
                  SizedBox(height: 20.0),
                  defaultButton(
                    label: 'LOGOUT',
                    onPressed: () => pp.logoutUser(context),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rocket_elevators/app/core/message_labels.dart';
import 'package:rocket_elevators/app/core/properties.dart';
import 'package:rocket_elevators/app/core/routes.dart';
import 'package:rocket_elevators/app/modules/login/components/cupertino_email_field.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../login_controller.dart';

class LoginViewCupertino extends StatefulWidget {
  @override
  _LoginViewMaterialState createState() => _LoginViewMaterialState();
}

class _LoginViewMaterialState extends State<LoginViewCupertino> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _properties = Get.find<Properties>();
  final _messages = Get.find<MessageLabels>();
  final _controller = Get.find<LoginController>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(_properties.appTitle)),
      resizeToAvoidBottomInset: false,
      backgroundColor: CupertinoColors.lightBackgroundGray,
      child: SafeArea(

        child: Center(
            child: Column(children: [

          Flexible(
              fit: FlexFit.tight,
              child: Container(
                  width: double.infinity,
                  child: Image(image: AssetImage(_properties.appLogo)))),
          Flexible(
              fit: FlexFit.tight,
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      padding: EdgeInsets.all(18),
                      child: CupertinoEmailField(controller: _emailController)))),
          Flexible(
              fit: FlexFit.tight,
              child: Container(
                // temp change
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Material(
                    color: CupertinoColors.systemBlue,
                    child: InkWell(
                        child: const Image(
                          image: AssetImage('assets/elevator-btn.png'),
                          width: double.infinity,
                        ),
                        onTap: () {
                          var checkEmail = _validateEmail(context, _formKey.currentState);
                          FocusScope.of(context).unfocus();
                          if (checkEmail) {
                                    _controller
                                        .authentication(_emailController.text.trim())
                                        .then((value) =>
                                    value
                                        ? Get.toNamed(Routes.ELEVATOR_LIST_URL)
                                        : Get.defaultDialog(
                                        title: _messages.opss_fail_title,
                                        middleText:_messages.auth_fail_content)
                                    );
                          }
                        }),
                  )))
        ])),
      ));

  bool _validateEmail(BuildContext context, FormState? formState) {
    final form = formState!;
    if (form.validate()) return true;
    return false;
  }
}
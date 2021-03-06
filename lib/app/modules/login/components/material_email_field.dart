import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rocket_elevators/app/core/message_labels.dart';
import 'package:get/instance_manager.dart';

class MaterialEmailField extends StatefulWidget {
  final TextEditingController controller;

  const MaterialEmailField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _MaterialEmailFieldState createState() => _MaterialEmailFieldState();
}

class _MaterialEmailFieldState extends State<MaterialEmailField> {
  final _messages = Get.find<MessageLabels>();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(Icons.mail),
          suffixIcon: widget.controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => widget.controller.clear(),
                ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? _messages.email_format_field
            : null,
      );
}
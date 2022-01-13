import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:rocket_elevators/app/core/message_labels.dart';
import 'package:get/instance_manager.dart';

class CupertinoEmailField extends StatefulWidget {
  final TextEditingController controller;

  const CupertinoEmailField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CupertinoEmailFieldState createState() => _CupertinoEmailFieldState();
}

class _CupertinoEmailFieldState extends State<CupertinoEmailField> {
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
  Widget build(BuildContext context) =>
      CupertinoTextFormFieldRow(
        controller: widget.controller,
        placeholder: 'Email',
        style: (
            DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.25)
        ),

        // prefix: Icon(CupertinoIcons.mail),
        keyboardType: TextInputType.emailAddress,
        // suffix: widget.controller.text.isEmpty
        //     ? Container(width: 0)
        //     : CupertinoButton(
        //         child: Icon(CupertinoIcons.clear),
        //         onPressed: () => widget.controller.clear(),
        //       ),
        decoration: BoxDecoration(
          color: CupertinoColors.extraLightBackgroundGray,
          border: Border.all(color: CupertinoColors.extraLightBackgroundGray, width: 6),
          borderRadius: BorderRadius.circular(6),
        ),
        validator: (email) =>
        email != null && !EmailValidator.validate(email)
            ? _messages.email_format_field
            : null,
      );
}
import 'package:blockie_app/widgets/basic_icon_button.dart';
import 'package:flutter/material.dart';

import '../extensions/font_weight_compat.dart';

class BasicTextField extends StatefulWidget {
  final String text;
  final String? hintText;
  final bool autofocus;
  final bool showsUnderline;
  final void Function(String) onValueChanged;

  const BasicTextField({
    Key? key,
    this.text = "",
    this.autofocus = false,
    this.hintText,
    this.showsUnderline = true,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.text;
    _textEditingController.addListener(() {
      widget.onValueChanged(_textEditingController.text);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      autofocus: true,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeightCompat.semiBold,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0x80FFFFFF),
            fontSize: 16,
            fontWeight: FontWeightCompat.semiBold,
          ),
          border: widget.showsUnderline ? null : InputBorder.none,
          enabledBorder: widget.showsUnderline
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                )
              : null,
          focusedBorder: widget.showsUnderline
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
              : null,
          suffix: _textEditingController.text.isNotEmpty
              ? BasicIconButton(
                  assetName: 'images/common/clear.png',
                  size: 22,
                  onTap: () {
                    _textEditingController.text = "";
                    setState(() {});
                  },
                )
              : null),
    );
  }
}

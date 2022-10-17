// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/widgets/basic_icon_button.dart';
import '../extensions/font_weight_compat.dart';

class BasicTextField extends StatefulWidget {
  final String text;
  final String? hintText;
  final bool autofocus;
  final bool showsUnderline;
  final Function(String) onValueChanged;

  const BasicTextField({
    Key? key,
    this.text = "",
    this.autofocus = false,
    this.hintText,
    this.showsUnderline = false,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.text,
        selection: TextSelection.collapsed(offset: widget.text.length),
      ),
    );
    return TextField(
      controller: _controller
        ..addListener(() => widget.onValueChanged(_controller.text)),
      autofocus: widget.autofocus,
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
          suffix: _controller.text.isNotEmpty
              ? BasicIconButton(
                  assetName: 'images/common/clear.png',
                  size: 22,
                  onTap: () {
                    widget.onValueChanged("");
                    _controller.text = "";
                  },
                )
              : null),
    );
  }
}

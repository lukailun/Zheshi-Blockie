// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/widgets/basic_icon_button.dart';
import '../extensions/font_weight_compat.dart';

class BasicTextField extends StatelessWidget {
  final String text;
  final int maxLines;
  final String? hintText;
  final bool autofocus;
  final bool showsUnderline;
  final Function(String)? onValueChanged;

  BasicTextField({
    super.key,
    this.text = '',
    this.maxLines = 1,
    this.autofocus = false,
    this.hintText,
    this.showsUnderline = false,
    this.onValueChanged,
  });

  final _currentText = ''.obs;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController.fromValue(
      TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      ),
    );
    _currentText.value = text;
    return Obx(
      () => TextField(
        controller: controller
          ..addListener(() {
            onValueChanged?.call(controller.text);
            _currentText.value = controller.text;
          }),
        maxLines: maxLines,
        autofocus: autofocus,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeightCompat.semiBold,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0x80FFFFFF),
            fontSize: 16,
            fontWeight: FontWeightCompat.semiBold,
          ),
          border: showsUnderline ? null : InputBorder.none,
          enabledBorder: showsUnderline
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                )
              : null,
          focusedBorder: showsUnderline
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
              : null,
          suffix: _currentText.value.isNotEmpty
              ? BasicIconButton(
                  assetName: 'assets/images/common/clear.png',
                  size: 22,
                  onTap: () {
                    onValueChanged?.call('');
                    controller.text = '';
                    _currentText.value = '';
                  },
                ).paddingOnly(left: 5)
              : null,
        ),
      ),
    );
  }
}

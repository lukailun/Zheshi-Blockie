// Flutter imports:
import 'package:blockie_app/extensions/extensions.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:blockie_app/widgets/basic_icon_button.dart';
import '../extensions/font_weight_compat.dart';

class BasicTextField extends StatelessWidget {
  final String text;
  final int maxLines;
  final int? maxLength;
  final String? hintText;
  final bool autofocus;
  final bool showsUnderline;
  final Function(String)? onValueChanged;

  BasicTextField({
    super.key,
    this.text = '',
    this.maxLines = 1,
    this.maxLength,
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
        maxLength: maxLength,
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
          counter: maxLength == null
              ? null
              : Text('${_currentText.value.length}/$maxLength')
                  .textColor(const Color(0x80FFFFFF))
                  .fontSize(14)
                  .paddingOnly(bottom: 17),
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

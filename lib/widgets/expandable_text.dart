// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:blockie_app/extensions/extensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({
    super.key,
    required this.text,
    required this.maxLines,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.text,
            softWrap: true,
            maxLines: _isExpanded ? 100 : widget.maxLines,
            overflow: TextOverflow.ellipsis,
          ).fontSize(14).textColor(const Color(0xCCFFFFFF)),
        ),
        Container(
          padding: const EdgeInsets.only(left: 7),
          child: GestureDetector(
            onTap: () {
              setState(() => _isExpanded = !_isExpanded);
            }, // Image tapped
            child: Image.asset(
              _isExpanded
                  ? "assets/images/common/collapse.png"
                  : "assets/images/common/expand.png",
              width: 24,
              height: 24,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  final int minLines;

  const DescriptionTextWidget({required this.text, required this.minLines});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  bool showText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          widget.text,
          softWrap: true,
          maxLines: showText ? 50 : widget.minLines,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xccffffff), fontSize: 14),
        )),
        Container(
          padding: const EdgeInsets.only(left: 7),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  showText = !showText;
                });
              }, // Image tapped
              child: Image.asset(
                  showText ? "images/collapse.png" : "images/expand.png",
                  width: 23,
                  height: 23)),
        )
      ],
    );
  }
}

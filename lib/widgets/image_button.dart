import 'package:flutter/cupertino.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({Key? key,
    this.imageUrl,
    this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  final imageUrl; //图片的地址
  final onPressed; //执行的方法
  final width; //宽
  final height; //高

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

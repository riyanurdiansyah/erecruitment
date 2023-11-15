import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar(
      {super.key, this.width, this.height, this.radius, this.progress});

  final double? width;
  final double? height;
  final double? radius;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
      child: Stack(
        children: [
          Container(
            width: ((width ?? 0) * (progress ?? 0)),
            height: height,
            decoration: BoxDecoration(
              color: progress! < 0.4
                  ? Colors.red
                  : progress! < 0.70
                      ? Colors.grey
                      : Colors.blue,
              borderRadius: BorderRadius.circular(radius ?? 10),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AppTextNormal.labelW600(
              "${(progress! * 100).toInt()}",
              10,
              progress! > 0.5 ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
        required this.text,this.onPressed,
        this.height,
        this.width,
        this.textColor = Colors.white,
        this.boxColor = AppColors.primaryColorBlack,
        this.borderColor = AppColors.primaryColorBlack,
        this.margin = 0})
      : super(key: key);

  final String text;
  final Function? onPressed;
  final double? height;
  final double? width;
  final Color textColor;
  final Color boxColor;
  final Color borderColor;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: margin ?? 0,right: margin ?? 0),
      height: height ?? 40,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: boxColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          onPressed?.call();
        },
        style:
        TextButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                //color: Color(0xFF0F1627),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

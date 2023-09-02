import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  const NumPad({
    Key? key,
    required this.onTap,
    this.isDisabled,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.clearIcon,
    this.themeColor,
    this.textStyle,
    this.numItemDecoration,
    this.buttonSize,
    this.backgroundColor,
    this.iconSize,
  }) : super(key: key);

  final ValueChanged<int> onTap;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final Icon? clearIcon;
  final Color? themeColor;
  final TextStyle? textStyle;
  final Decoration? numItemDecoration;
  final double? buttonSize;
  final Color? backgroundColor;
  final double? iconSize;
  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const values = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    var mSpacing = size.width * 0.02;
    var cSpacing = size.height * 0.02;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
      child: Opacity(
        opacity: isDisabled ?? false ? 0.5 : 1,
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: mainAxisSpacing ?? mSpacing,
          crossAxisSpacing: crossAxisSpacing ?? cSpacing,
          childAspectRatio: 1.5,
          crossAxisCount: 3,
          children: [
            ...List.generate(
              values.length,
              (index) => numItem(value: values[index], onTap: onTap),
            ),
            const SizedBox(),
            numItem(value: 0, onTap: onTap),
            numItem(
              value: 99,
              onTap: (isDisabled ?? false) ? () {} : onTap,
              widget: Icon(
                Icons.backspace_outlined,
                size: iconSize ?? 30,
                color: themeColor ?? Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget numItem({
    required int value,
    required Function onTap,
    Widget? widget,
  }) {
    var textSize = 38.0;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (() => onTap(value)),
      child: Container(
        decoration: numItemDecoration ?? const BoxDecoration(),
        child: Center(
          child: widget ??
              Text(
                "$value",
                style: textStyle ??
                    TextStyle(
                      fontSize: textSize,
                      color: themeColor ?? Colors.blueGrey,
                    ),
              ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handlit_flutter/utils/styles/palette.dart';

class CustomBoxInputFields extends StatelessWidget {
  final bool enabledCounter;
  final TextAlign? textAlign;
  final Color? backgroundColor;
  final String? title;
  final ThemeData? themeData;
  final TextEditingController controller;
  final TextStyle? textStyle;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final TextInputType keyboardType;
  final bool password;
  final String? label;
  final String? initialValue;
  final void Function()? trailingTapped;
  final void Function()? onTap;
  final bool readOnly;
  final int minLine;
  final int? maxLength;
  final String? Function(String?)? validator;
  final String? errorText;
  final void Function(String)? onChanged;
  final double? textHeight;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enableSuggestions;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final TextStyle? errorStyle;
  final EdgeInsets contentPadding;
  final bool isloading;
  final TextInputAction? textInputAction;

  const CustomBoxInputFields({
    Key? key,
    this.enabledCounter = true,
    required this.controller,
    this.backgroundColor,
    this.textAlign,
    this.textStyle,
    this.title,
    this.label,
    this.initialValue,
    this.placeholder = '',
    this.keyboardType = TextInputType.text,
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
    this.onTap,
    this.minLine = 1,
    this.maxLength,
    this.validator,
    this.errorText,
    this.onChanged,
    this.textHeight = 1,
    this.enabled,
    this.themeData,
    this.inputFormatters,
    this.enableSuggestions = true,
    this.onEditingComplete,
    this.focusNode,
    this.errorStyle,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
    this.isloading = false,
    this.readOnly = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final circularBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(8));

    return Theme(
      data: themeData != null ? themeData! : Theme.of(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null ? Text('$title') : const SizedBox.shrink(),
          title != null ? const SizedBox(height: 8) : const SizedBox.shrink(),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            textAlign: textAlign ?? TextAlign.start,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            enabled: enabled,
            onEditingComplete: onEditingComplete,
            autocorrect: !password,
            enableSuggestions: password ? false : enableSuggestions!,
            minLines: minLine,
            maxLines: minLine,
            maxLength: maxLength,
            onTap: onTap,
            controller: controller,
            style: textStyle ??
                TextStyle(
                  height: textHeight,
                  color: themeData != null ? themeData!.primaryColor.withAlpha(200) : Theme.of(context).primaryColor.withAlpha(200),
                  fontSize: MediaQuery.of(context).size.width <= 320 ? 14 : 14,
                ),
            obscureText: password,
            initialValue: initialValue,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            obscuringCharacter: '●',
            decoration: InputDecoration(
              counterText: enabledCounter ? null : '',
              errorStyle: errorStyle,
              counterStyle: TextStyle(color: themeData != null ? themeData!.primaryColor.withAlpha(150) : null),
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: textStyle != null
                    ? textStyle!.fontSize
                    : MediaQuery.of(context).size.width <= 320
                        ? 14
                        : 14,
                color: Theme.of(context).disabledColor,
              ),
              filled: true,
              fillColor: backgroundColor ?? Theme.of(context).colorScheme.background,
              prefixIcon: leading,
              suffixIcon: isloading
                  ? Transform.scale(scale: 0.3, child: const CircularProgressIndicator())
                  : trailing != null
                      ? InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: trailingTapped,
                          child: trailing,
                        )
                      : null,
              errorText: errorText,
              border: circularBorder.copyWith(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.1))),
              errorBorder: circularBorder.copyWith(borderSide: BorderSide(color: themeData != null ? themeData!.colorScheme.error : Palette.onErrorColor)),
              focusedBorder: circularBorder.copyWith(borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.5))),
              enabledBorder: circularBorder.copyWith(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.1))),
              labelText: label,
              contentPadding: contentPadding,
            ),
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}

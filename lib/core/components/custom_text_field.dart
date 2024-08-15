import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final int? maxLines;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final dynamic onTapOutside;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isEnable;
  final String? Function(String?)? validator;
  final String? hintText;
  final List<String>? validationMessages;

  const CustomTextField({
    super.key,
    this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.focusNode,
    this.onChanged,
    this.validationMessages,
    this.onTapOutside,
    this.onTap,
    this.maxLines,
    this.labelStyle,
    this.prefixIcon,
    this.isEnable,
    this.style,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color _borderColor = Colors.black.withOpacity(0.6);
  List<bool> _validationStates = [];

  @override
  void initState() {
    super.initState();
    if (widget.validationMessages != null) {
      _validationStates = List.filled(widget.validationMessages!.length, false);
    }
  }

  void _updateValidationState(String value) {
    setState(() {
      _validationStates = [
        value.length > 8,
        value.contains(RegExp(r'[A-Z]')),
        value.contains(RegExp(r'[0-9]')),
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      ];
      _borderColor = _validationStates.every((isValid) => isValid)
          ? Colors.green
          : AppColors.redColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Column(
            children: [
              Text(
                widget.labelText!,
                style: widget.labelStyle ??
                    Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                        ),
              )
            ],
          ),
        const SizedBox(height: 6),
        Listener(
          onPointerDown: (event) {
            if (widget.onTapOutside != null) {
              widget.onTapOutside!(event);
            }
          },
          child: TextFormField(

            enabled: widget.isEnable,
            onChanged: (value) {
              if (widget.validationMessages != null) {
                _updateValidationState(value);
              }
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            focusNode: widget.focusNode,

            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16),
            onTap: widget.onTap,

            controller: widget.controller,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            // Ensure single line for password
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            textInputAction: widget.textInputAction,
            obscureText: widget.obscureText,

            decoration: InputDecoration(

              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: widget.prefixIcon,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: widget.suffixIcon,
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: _borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.redColor, width: 1),
                gapPadding: 8,
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.redColor, width: 1),
                gapPadding: 8,
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(color:_borderColor),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        if (widget.validationMessages != null)
          ...List.generate(widget.validationMessages!.length, (index) {
            return Text(
              widget.validationMessages![index],
              style: TextStyle(
                color: _validationStates[index]
                    ? AppColors.greenColor
                    : AppColors.redColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            );
          })
      ],
    );
  }
}

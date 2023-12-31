import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.controller,
    this.autofocus,
    this.hintText,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.validationText,
    this.suffixIcon,
    this.floatingLabelBehavior,
    this.obscureText,
    this.width,
    this.height,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final bool? autofocus;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final Widget? suffixIcon;
  final String? validationText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? obscureText;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        autofocus: autofocus ?? false,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText ?? false,
        style: themeData.textTheme.titleMedium,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: 20,
          ),
          suffixIcon: suffixIcon,
          labelStyle: Theme.of(context).textTheme.titleMedium,
          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.auto,
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 129, 52, 150)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 167, 65, 193)),
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.red),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationText;
          }
          return null;
        },
      ),
    );
  }
}

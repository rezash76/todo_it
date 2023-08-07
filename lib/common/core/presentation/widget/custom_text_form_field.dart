import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:zoop_flutter/core/themes/color_palettes/color_palette.dart';

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
    // this.svgPicture,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final bool? autofocus;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  // final SvgPicture? svgPicture;
  final String? validationText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus ?? false,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 20,
          bottom: 20,
        ),
        // suffixIcon: svgPicture,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 202, 82, 236)),
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
    );
  }
}

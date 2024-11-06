import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/theme/theme.dart';

class TextFieldOtp extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? initialValue;

  const TextFieldOtp({
    super.key,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(),
      borderRadius:
          BorderRadius.circular(SizesApp.sizesLoginApp.kBorderRadious),
    );
    return SizedBox(
      width: 50,
      height: 68,
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderRadius:
                  BorderRadius.circular(SizesApp.sizesLoginApp.kBorderRadious)),
          enabledBorder: border,
          focusedBorder: border,
          isDense: true,
          hintText: '-',
        ),
        style: Theme.of(context).textTheme.headlineLarge,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }
}

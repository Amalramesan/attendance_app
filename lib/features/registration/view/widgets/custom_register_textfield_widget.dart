import 'package:flutter/material.dart';

class RegisterTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const RegisterTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
  });

  @override
  State<RegisterTextField> createState() =>
      _RegisterTextFieldState();
}

class _RegisterTextFieldState
    extends State<RegisterTextField> {

  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(widget.label),

        const SizedBox(height: 8),

        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,

          decoration: InputDecoration(
            hintText: widget.hintText,

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8),
            ),

            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText =
                            !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
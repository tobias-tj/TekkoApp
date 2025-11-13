import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class InputAccount extends StatefulWidget {
  final String hintText;
  final bool isPass;
  final TextInputType inputType;
  final TextEditingController inputController;
  final String? errorText;
  final Function(String)? onChanged;

  const InputAccount({
    super.key,
    required this.hintText,
    required this.isPass,
    required this.inputType,
    required this.inputController,
    this.errorText,
    this.onChanged,
  });

  @override
  State<InputAccount> createState() => _InputAccountState();
}

class _InputAccountState extends State<InputAccount> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: const Color.fromARGB(49, 92, 54, 9),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: widget.errorText == null
                  ? Colors.transparent
                  : Colors.redAccent.withOpacity(0.6),
              width: 1.2,
            ),
          ),
          child: TextField(
            controller: widget.inputController,
            keyboardType: widget.inputType,
            obscureText: widget.isPass ? _obscureText : false,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.black45),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
              suffixIcon: widget.isPass
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.chocolateNewDark,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : null,
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}

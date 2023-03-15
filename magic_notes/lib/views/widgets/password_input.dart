import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  late String label;
  late String hintText;
  late TextEditingController passwordController;

  PasswordInput({
    required this.label,
    required this.hintText,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 100,
      controller: widget.passwordController,
      obscureText: _passwordVisible,
      //This will obscure text dynamically
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.label,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

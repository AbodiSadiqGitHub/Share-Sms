import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onPressed;
  const CustomButton({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: CustomText(text: text),
      ),
    );
  }
}

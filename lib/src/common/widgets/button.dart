import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.svgIconPath,
    this.icon,
  });

  final String text;
  final void Function()? onPressed;
  final Color? buttonColor, textColor;
  final String? svgIconPath;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(buttonColor ?? Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgIconPath != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(svgIconPath!, width: 20, height: 20),
              ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: icon,
              ),
            Text(text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}

class CustomSecondaryButton extends StatelessWidget {
  const CustomSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.icon,
  });

  final String text;
  final void Function()? onPressed;
  final Color? buttonColor, textColor;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: WidgetStateProperty.all(buttonColor ?? Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: icon,
              ),
          ],
        ),
      ),
    );
  }
}

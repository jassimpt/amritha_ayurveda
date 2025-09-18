import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w500,
    this.overflow = false,
    this.size = 15,
  });

  final String text;
  final TextAlign textAlign;
  final Color? color;
  final FontWeight fontWeight;
  final bool overflow;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: overflow ? 1 : null,
      overflow: overflow ? TextOverflow.ellipsis : null,
      style: GoogleFonts.figtree(
        color: color ?? Colors.black,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}

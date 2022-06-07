import 'package:admin_api/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double size, [Color? color, FontWeight? fw]) {
  return GoogleFonts.roboto(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

myStyles14() {
  return GoogleFonts.roboto(
    fontSize: 14,
    color: BrandColors.colorText,
  );
}

myStyles12() {
  return GoogleFonts.roboto(
    fontSize: 12,
    color: BrandColors.colorText,
  );
}

myStyles16() {
  return GoogleFonts.roboto(
    fontSize: 16,
    color: BrandColors.colorText,
    fontWeight: FontWeight.w400,
  );
}

myStyles18() {
  return GoogleFonts.roboto(
    fontSize: 18,
    color: BrandColors.colorText,
    fontWeight: FontWeight.w700,
  );
}

myStyles20() {
  return GoogleFonts.roboto(
    fontSize: 20,
    color: BrandColors.colorText,
    fontWeight: FontWeight.w700,
  );
}
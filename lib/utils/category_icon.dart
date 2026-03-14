import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

Icon getCategoryIcon(String category) {

  switch (category.toLowerCase()) {

    case "fruta":
      return const Icon(LucideIcons.apple, size: 20);

    case "verdura":
      return const Icon(LucideIcons.carrot, size: 20);

    case "legumbre":
      return const Icon(LucideIcons.bean, size: 20);      

    case "hidratos":
      return const Icon(LucideIcons.wheat, size: 20);

    case "carne_magra":
      return const Icon(LucideIcons.beef, size: 20);

    case "carne_grasa_media":
      return const Icon(LucideIcons.drumstick, size: 20);

    case "carne_grasa_alta":
      return const Icon(LucideIcons.drumstick, size: 20);

    case "pescado_magro":
      return const Icon(LucideIcons.fish, size: 20);

    case "pescado_grasa_media":
      return const Icon(LucideIcons.fish, size: 20);

    case "pescado_grasa_alta":
      return const Icon(LucideIcons.fish, size: 20);

    case "huevo_magro":
      return const Icon(LucideIcons.egg, size: 20);

    case "huevo_grasa":
      return const Icon(LucideIcons.eggFried, size: 20);

    case "lacteo_magro":
      return const Icon(LucideIcons.cupSoda, size: 20);

    case "lacteos":
      return const Icon(LucideIcons.milk, size: 20);

    case "tuberculos":
      return const Icon(LucideIcons.vegan, size: 20);

    case "frutos_secos":
      return const Icon(LucideIcons.nut, size: 20);

    case "azucar":
      return const Icon(LucideIcons.lollipop, size: 20);

    case "otros":
      return const Icon(LucideIcons.cupSoda, size: 20);

    default:
      return const Icon(LucideIcons.utensils, size: 20);

  }

}
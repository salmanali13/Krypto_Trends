//------------------------------------------------------------------------------
// This is the choice chip model class that holds the hardcoded data of the list
// of all the choice chips available in the apps

import 'dart:ui';

import 'package:flutter/material.dart';

//-------------------------------------------------------------
// This is the Choice Chip model class
class ChoiceChipData {
  final String label;
  final bool isSelected;
  Color textColor;
  Color selectedColor;
  Color selectedTextColor;

  ChoiceChipData(
      {this.label,
      this.isSelected,
      this.textColor,
      this.selectedColor,
      this.selectedTextColor});

  //---------------- This Function takes parameters & saves it in the object ----------------
  ChoiceChipData copy({
    String label,
    bool isSelected,
    Color textColor,
    Color selectedColor,
    Color selectedTextColor,
  }) =>
      ChoiceChipData(
        label: label ?? this.label,
        isSelected: isSelected ?? this.isSelected,
        textColor: textColor ?? this.textColor,
        selectedColor: selectedColor ?? this.selectedColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          isSelected == other.isSelected &&
          textColor == other.textColor &&
          selectedColor == other.selectedColor &&
          selectedTextColor == other.selectedTextColor;

  @override
  int get hashCode =>
      label.hashCode ^
      isSelected.hashCode ^
      textColor.hashCode ^
      selectedColor.hashCode ^
      selectedTextColor.hashCode;
}

/// Choice Chip Data///

class ChoiceChips {
  static final all = <ChoiceChipData>[
    // ChoiceChipData(
    //   label: '1H',
    //   isSelected: false,
    //   // selectedColor: Colors.yellow,
    //   textColor: Colors.white,
    // ),
    ChoiceChipData(
      label: '1D',
      isSelected: false,
      textColor: Colors.white,
    ),
    ChoiceChipData(
        label: '7D',
        isSelected: false,
        textColor: Colors.white,
        selectedTextColor: Colors.amberAccent),
    ChoiceChipData(
        label: '1M',
        isSelected: true,
        textColor: Colors.white,
        selectedTextColor: Colors.amberAccent),
    ChoiceChipData(
        label: '6M',
        isSelected: false,
        textColor: Colors.white,
        selectedTextColor: Colors.amberAccent),
    ChoiceChipData(
        label: '1Y',
        isSelected: false,
        textColor: Colors.white,
        selectedTextColor: Colors.amberAccent),
    ChoiceChipData(
        label: '3Y',
        isSelected: false,
        textColor: Colors.white,
        selectedTextColor: Colors.amberAccent),
    ChoiceChipData(
        label: '5Y',
        isSelected: false,
        textColor: Colors.white,
        selectedTextColor: Colors.amberAccent),
  ];
}

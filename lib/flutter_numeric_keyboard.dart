/// A Flutter widget for displaying a numeric keyboard.
///
/// This widget allows users to input numeric values through a customizable
/// interface. It supports various customization options such as setting
/// the width, height, colors, styles, and icons.

import 'package:flutter/material.dart';

class FlutterNumericKeyboard extends StatefulWidget {
  /// The width of the keyboard
  final double? width;

  /// The height of the keyboard.
  final double? height;

  /// Whether to show the result field above the keyboard.
  final bool? showResult;

  /// A callback function to handle the result value.
  final Function(String value)? resultFunction;

  /// Whether to obscure the result value.
  final bool? obscureResult;

  /// Whether to show the divider between rows and columns.
  final bool? showDivider;

  /// The color of the divider.
  final Color? dividerColor;

  /// The style for the digits.
  final TextStyle? digitStyle;

  /// The text style for the result field.
  final TextStyle? resultTextStyle;

  /// The background color of the keyboard.
  final Color? backgroundColor;

  /// The border radius of the keyboard background.
  final double? backgroundRadius;

  /// Whether to show the right icon.
  final bool? showRightIcon;

  /// The icon for the back action.
  final Icon? rightIconBack;

  /// The icon for the reset action.
  final Icon? leftIconReset;

  /// Whether to show the left icon.
  final bool? showLeftIcon;

  const FlutterNumericKeyboard({
    super.key,
    this.width,
    this.height,
    this.showResult = true,
    this.resultFunction,
    this.obscureResult = false,
    this.showDivider = true,
    this.dividerColor,
    this.digitStyle,
    this.resultTextStyle,
    this.backgroundColor,
    this.backgroundRadius,
    this.showRightIcon,
    this.rightIconBack,
    this.leftIconReset,
    this.showLeftIcon,
  });

  @override
  State<FlutterNumericKeyboard> createState() => _FlutterNumericKeyboardState();
}

class _FlutterNumericKeyboardState extends State<FlutterNumericKeyboard> {
  /// The currently inputted numeric value.
  String resultNumber = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Visibility(
          visible: widget.showResult!,
          child: Text(
              widget.obscureResult == true
                  ? obscureString(resultNumber)
                  : resultNumber,
              style: widget.resultTextStyle ??
                  const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Material(
          // wrap container with material to show inkwell splash effect when click
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(widget.backgroundRadius ?? 0),
          child: Container(
            width: widget.width ?? 300,
            height: widget.height ?? 400,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                    child: buildRow("7", "8", "9", size, widget.dividerColor)),
                (widget.showDivider == null || widget.showDivider == true)
                    ? buildHorizontalDivider(size, widget.dividerColor)
                    : const SizedBox.shrink(),
                Expanded(
                    child: buildRow("4", "5", "6", size, widget.dividerColor)),
                (widget.showDivider == null || widget.showDivider == true)
                    ? buildHorizontalDivider(size, widget.dividerColor)
                    : const SizedBox.shrink(),
                Expanded(
                    child: buildRow("1", "2", "3", size, widget.dividerColor)),
                (widget.showDivider == null || widget.showDivider == true)
                    ? buildHorizontalDivider(size, widget.dividerColor)
                    : const SizedBox.shrink(),
                Expanded(
                    child: buildRow(
                        "Reset", "0", "Back", size, widget.dividerColor))
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a row of digits for the keyboard.
  Widget buildRow(String leftNumber, String middleNumber, String rightNumber,
      Size size, Color? dividerColor) {
    return Row(
      children: [
        //left number
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                if (leftNumber != "Reset") {
                  setState(() {
                    resultNumber += leftNumber;
                  });
                } else {
                  setState(() {
                    resultNumber = "";
                  });
                }
                if (widget.resultFunction != null) {
                  widget.resultFunction!(resultNumber);
                }
              },
              child: (leftNumber == "Reset")
                  ? Visibility(
                      visible: (widget.showLeftIcon == null ||
                          widget.showLeftIcon == true),
                      child: Center(
                          child: widget.leftIconReset ??
                              const Icon(Icons.refresh, color: Colors.black)),
                    )
                  : Center(
                      child: Text(
                        leftNumber,
                        style: widget.digitStyle,
                      ),
                    ),
            )),

        //divider
        Visibility(
          visible: (widget.showDivider == null || widget.showDivider == true),
          child: leftNumber == "7"
              ? buildTopDivider(size, widget.dividerColor)
              : (leftNumber == "4" || leftNumber == "1")
                  ? buildMiddleDivider(size, widget.dividerColor)
                  : buildBottomDivider(size, widget.dividerColor),
        ),

        // middle number
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                resultNumber += middleNumber;
              });
              if (widget.resultFunction != null) {
                widget.resultFunction!(resultNumber);
              }
            },
            child: Center(
              child: Text(
                middleNumber,
                style: widget.digitStyle,
              ),
            ),
          ),
        ),

        //divider
        Visibility(
          visible: (widget.showDivider == null || widget.showDivider!),
          child: leftNumber == "7"
              ? buildTopDivider(size, widget.dividerColor)
              : (leftNumber == "4" || leftNumber == "1")
                  ? buildMiddleDivider(size, widget.dividerColor)
                  : buildBottomDivider(size, widget.dividerColor),
        ),

        //right number
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              if (rightNumber != "Back") {
                setState(() {
                  resultNumber +=
                      rightNumber; // Adding a letter 'A' to the string
                });
              } else {
                if (resultNumber.trim().isNotEmpty) {
                  setState(() {
                    resultNumber = resultNumber.substring(
                        0, resultNumber.length - 1); // Remove last character
                  });
                }
              }
              if (widget.resultFunction != null) {
                widget.resultFunction!(resultNumber);
              }
            },
            child: (rightNumber == "Back")
                ? Visibility(
                    visible: (widget.showRightIcon == null ||
                        widget.showRightIcon == true),
                    child: Center(
                        child: widget.rightIconBack ??
                            const Icon(Icons.backspace, color: Colors.black)),
                  )
                : Center(
                    child: Text(
                      rightNumber,
                      style: widget.digitStyle,
                    ),
                  ),
          ),
        )
      ],
    );
  }

  /// Builds a horizontal divider between rows.
  Widget buildHorizontalDivider(Size size, Color? dividerColor) {
    return Container(
      width: size.width,
      height: 1,
      decoration: BoxDecoration(
          gradient: dividerColor == null
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white10,
                    Colors.black12,
                    Colors.black26,
                    Colors.black26,
                    Colors.black26,
                    Colors.black26,
                    Colors.black12,
                    Colors.white10,
                  ],
                )
              : null,
          color: dividerColor),
    );
  }

  /// Builds a vertical divider for the top part of the keyboard.
  Widget buildTopDivider(Size size, Color? dividerColor) {
    return Container(
      width: 1,
      height: size.height,
      decoration: BoxDecoration(
          gradient: dividerColor == null
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white10,
                    Colors.black12,
                    Colors.black26,
                    Colors.black26,
                  ],
                )
              : null,
          color: dividerColor),
    );
  }

  /// Builds a vertical divider for the bottom part of the keyboard.
  Widget buildBottomDivider(Size size, Color? dividerColor) {
    return Container(
      width: 1,
      height: size.height,
      decoration: BoxDecoration(
          gradient: dividerColor == null
              ? const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white10,
                    Colors.black12,
                    Colors.black26,
                    Colors.black26,
                  ],
                )
              : null,
          color: dividerColor),
    );
  }

  /// Builds a vertical divider for the middle part of the keyboard.
  Widget buildMiddleDivider(Size size, Color? dividerColor) {
    return Container(
      width: 1,
      height: size.height,
      color: dividerColor ?? Colors.black26,
    );
  }

  /// Obscures the inputted string by replacing each character with '*'.
  String obscureString(String input) {
    return input.replaceAll(RegExp(r'.'), '*');
  }
}

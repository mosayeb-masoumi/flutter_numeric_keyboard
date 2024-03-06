import 'package:flutter/material.dart';

class FlutterNumericKeyboard extends StatefulWidget {
  final double? width;
  final double? height;
  final bool? showResult;
  final Function(String value)? resultFunction;
  final bool? obscureResult;
  final bool? showDivider;
  final Color? dividerColor;
  final TextStyle? digitStyle;
  final TextStyle? resultTextStyle;
  final Color? backgroundColor;
  final double? backgroundRadius;
  final bool? showRightIcon;
  final Icon? rightIconBack;
  final Icon? leftIconReset;
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

  Widget buildTopDivider(Size size, Color? dividerColor) {
    return Container(
      width: 1,
      height: size.height,
      decoration: BoxDecoration(
          gradient: dividerColor == null
              ?const LinearGradient(
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

  Widget buildMiddleDivider(Size size, Color? dividerColor) {
    return Container(
      width: 1,
      height: size.height,
      color: dividerColor ?? Colors.black26,
    );
  }

  String obscureString(String input) {
    return input.replaceAll(RegExp(r'.'), '*');
  }
}

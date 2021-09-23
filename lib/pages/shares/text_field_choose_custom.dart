import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';

class TextFieldChooseCustom extends StatefulWidget {
  TextFieldChooseCustom(
      {this.data,
      this.title,
      this.iconRight,
      this.sizeIconRight = 18,
      this.onTap,
      this.textInputAction});

  final String? data;
  final String? title;
  final IconData? iconRight;
  final double? sizeIconRight;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  @override
  _TextFieldChooseCustomState createState() => _TextFieldChooseCustomState();
}

class _TextFieldChooseCustomState extends State<TextFieldChooseCustom> {
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController =
        TextEditingController(text: widget.data == null ? '' : widget.data);
    return InkWell(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: TextField(
          enabled: false,
          controller: _textEditingController,
          textAlign: TextAlign.left,
          style: CustomTheme.bodyText2(context),
          decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(8),
              suffixIconConstraints:
                  BoxConstraints(minWidth: 30, maxHeight: 20),
              suffixIcon: GestureDetector(
                child: Container(
                    child: SizedBox(
                  child: Icon(
                    widget.iconRight,
                    size: widget.sizeIconRight,
                  ),
                )),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.black)),
              hintText: widget.title),
        ),
      ),
      onTap: widget.onTap,
    );
  }
}

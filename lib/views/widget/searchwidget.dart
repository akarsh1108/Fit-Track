import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  SearchWidget(this.text, this.onChanged, this.hintText);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Color(0xFF006484));
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Color(0xFF1FB5E4))),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
              icon: Icon(Icons.search, color: style.color),
              suffixIcon: widget.text.isNotEmpty
                  ? GestureDetector(
                      child: Icon(Icons.close, color: style.color),
                      onTap: () {
                        controller.clear();
                        widget.onChanged('');
                       
                      })
                  : null,
                  hintText:widget.hintText,
                  hintStyle: style,
                  border: InputBorder.none,),),
    );
  }
}

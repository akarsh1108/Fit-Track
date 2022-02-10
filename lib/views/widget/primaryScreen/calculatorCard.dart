import 'package:fittrack/constants/uiconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CategoryCard extends StatelessWidget {
  final String pngSrc;
  final String title;
  final VoidCallback press;
  const CategoryCard({

    required this.pngSrc,
    required this.title,
   required this.press,
  }) ;

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size; 
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF1FB5E4)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: 23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Expanded(
                    flex: 10,
                    child: Image.asset(pngSrc)),
                  Spacer(),
                  Container(
                    width: size.width,
                    color: Color(0xFF1FB5E4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,style: TextStyle(color: Colors.white
                        ),
                        
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
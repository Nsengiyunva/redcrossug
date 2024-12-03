import 'package:flutter/material.dart';

class GreenBadge extends StatelessWidget {
  const GreenBadge({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 80.0,
    //   height: 80.0,
    //   decoration: BoxDecoration(
    //     color: Colors.green,
    //     shape: BoxShape.circle,
    //     border: Border.all(
    //       color: Colors.green,
    //       width: 2.0 
    //     )
    //   ),
    // );
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular( 80 )
      ),
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular( 30 )
          ),
          child: Icon(
                Icons.check,
                color: Colors.green,
                size: 30.0,
              ),
        )
      ),
    );
  }
}
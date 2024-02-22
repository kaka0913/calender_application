import 'package:calender_application/common/schedule_carousel.dart';
import 'package:flutter/material.dart';

class CarouselView extends StatelessWidget {
  const CarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Stack(
            children: <Widget>[
              ScheduleCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

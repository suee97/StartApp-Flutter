import 'package:flutter/material.dart';
import '../../../screens/home/rent/items_calendar_widget.dart';

class RentItemsCalendar extends StatelessWidget{

  const RentItemsCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("헤더"),
          ItemsCalendarWidget(),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "신청완료.");
              },
              child: const Text("신청하기")),
        ],
      ),
    );
  }
}
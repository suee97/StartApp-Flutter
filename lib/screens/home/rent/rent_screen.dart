import 'package:flutter/material.dart';
import 'package:start_app/widgets/test_button.dart';
import 'detail/amp_rent_screen.dart';

class RentScreen extends StatelessWidget {
  const RentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("rent screen"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TestButton(
            title: "앰프",
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AmpRentScreen()))
            },
          ),
          TestButton(
            title: "듀라",
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AmpRentScreen()))
            },
          ),
          TestButton(
            title: "케너피",
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AmpRentScreen()))
            },
          ),
        ],
      ),
    );
  }
}

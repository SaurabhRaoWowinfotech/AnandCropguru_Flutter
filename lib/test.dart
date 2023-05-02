import 'package:dr_crop_guru/utils/util.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget{
  static final routeName = '/test';

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with TickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.reset();
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Dialog'),
          onPressed: (){
            Util.animatedProgressDialog(context, _controller);
          },
        ),
      ),
    );
  }
}

// showDialog(
// context: context,
// builder: (context) {
// return FutureBuilder(
// future: otpResponse
// builder: (context, snapshot) {
//
//
// };
// );
// // Navigator.of(context)
// //     .pushReplacementNamed(HomePage.routeName);
// },
//
// ),
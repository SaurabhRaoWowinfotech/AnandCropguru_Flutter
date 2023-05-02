



import 'package:flutter/material.dart';

class MyHomePageee extends StatefulWidget {
  @override
  _MyHomePageeeState createState() => _MyHomePageeeState();
}

class _MyHomePageeeState extends State<MyHomePageee> {
  DateTime selectedDate = DateTime(2020, 1, 14);

  // DatePicker will call this function on every day and expect
  // a bool output. If it's true, it will draw that day as "enabled"
  // and that day will be selectable and vice versa.
  bool _predicate(DateTime day) {
    if ((day.isAfter(DateTime(2020, 1, 5)) &&
        day.isBefore(DateTime(2020, 1, 9)))) {
      return true;
    }

    if ((day.isAfter(DateTime(2020, 1, 10)) &&
        day.isBefore(DateTime(2020, 1, 15)))) {
      return true;
    }
    if ((day.isAfter(DateTime(2020, 2, 5)) &&
        day.isBefore(DateTime(2020, 2, 17)))) {
      return true;
    }

    return false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        selectableDayPredicate: _predicate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2021),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
                primaryColor: Colors.orangeAccent,
                disabledColor: Colors.brown,
                textTheme:
                TextTheme(bodyText1: TextStyle(color: Colors.blueAccent)),
                accentColor: Colors.yellow),
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}
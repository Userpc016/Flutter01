import 'package:flutter/material.dart';



class AppCounter extends StatefulWidget {
  const AppCounter ({super.key});

  @override
  State<AppCounter> createState() => _AppCounterState();
}

int count = 0;

class _AppCounterState extends State <AppCounter> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      count += 1;
                    });
                  },
                  child: Text ("PLUS")
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              width: double.infinity,
              height: 200,
              child: Center(
                child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  count -=1;
                });
              },
              child: Text("MINUS"),
            ),
          ),
        ],
       ),
      )
    );
  }
}
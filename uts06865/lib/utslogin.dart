import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts06865/uts.dart';

class utslogin extends StatefulWidget {
  const utslogin ({super.key});

  @override
  State<utslogin> createState() => _utsloginState();
}

class _utsloginState extends State<utslogin> {
  Future<void> tableCreate() async {
    final database = await openDatabase('mahasiswaa_db.db');
    await database.execute('CREATE TABLE mhs_table(nim INTEGER PRIMARY KEY, nama TEXT)',);
    await database.execute('SELECT * FROM mhs_table');
    print('created!');
  }
  Future<void> showTable() async {
    final database = await openDatabase('mahasiswaa_db.db');
    final List<Map<String, dynamic>> table = await database.query('mhs_table');
    for (final table in table)
    {
      print("Table: $table");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UTS!"),),
      body: Center(
        child: Container(
          // padding: EdgeInsets.all(double.infinity),
          // width: double.infinity,
          // height: double.infinity,
          child: Form(child: Column(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => utshome(),),);
              }, child: Text("login"),),

            ],
          ),),
        ),
      ),
    );
  }
}

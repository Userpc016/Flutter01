import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class utshome extends StatefulWidget {
  const utshome ({super.key}); 
  @override
  State<utshome> createState() => _utsloginState();
}

class _utsloginState extends State<utshome> {
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  
  late dynamic db = null;
  List<Map<String, Object?>> mahasiswa = [];

  @override
  void initState() {
    //
    super.initState();
    setupDatabase();
  }
  
  void setupDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'mhs_DB.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tabelMHS(nim INTEGER PRIMARY KEY, nama TEXT, alamat TEXT)',
        );
      },
      version: 1,
    );
    db = await database;
    retrieve();
  }

  void save() async {
    await db.insert(
      'tabelMHS',
      {
        "nim": nimController.text,
        "nama": namaController.text,
        "alamat": alamatController.text
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
    retrieve();
  }

  void retrieve() async {
    final List<Map<String, Object?>> mahasiswa = await db.query('tabelMHS');
    setState(() {
      this.mahasiswa = mahasiswa;
    },);
  }

void deleteRow(nim) async {
  await db.delete(
    'tabelMHS',
    where: 'nim = ?',
    whereArgs: [nim],
  );
  retrieve();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar (title: const Text("input Data Mahasiswa"),),
    body: Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          TextField(
            controller: nimController,
            decoration: const InputDecoration(
              label: Text ("NIM"),
            ),
          ),
          TextField(
            controller: namaController,
            decoration: const InputDecoration(
              label: Text("Nama Mahasiswa")
            ),
          ),
          TextField(
            controller: alamatController,
            decoration: const InputDecoration(
              label: Text("Alamat Mahasiswa")
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              save();
            },
            child: const Text("Simpan Data"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text('NIM'),
                    ),
                    DataColumn(
                      label: Text('Nama'),
                    ),
                    DataColumn(
                      label: Text('Alamat'),
                    ),
                    DataColumn(
                      label: Text('Action'),
                    ),
                  ],
                  rows: mahasiswa
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            e['nim'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            e['nama'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            e['alamat'].toString(),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            onPressed: () {
                                deleteRow(e['nim']);
                              },
                              icon: const Icon(Icons.delete),
                              ),
                            )
                          ]
                        ),
                      )
                        .toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'editdataspp.dart';
import 'tambahdataspp.dart';

class DataSppPage extends StatefulWidget {
  const DataSppPage({Key? key}) : super(key: key);

  @override
  _DataSppPageState createState() => _DataSppPageState();
}

class _DataSppPageState extends State<DataSppPage> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.161.140/spp_login_signup/readspp.php'));
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.161.140/spp_login_signup/hapusspp.php'),
          body: {
            "tahun": id,
          });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text('Data SPP'),
          backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 0, 138, 251), Color.fromARGB(255, 64, 232, 251),], // Warna yang digunakan
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()), // Ganti DashBoard dengan nama kelas halaman Dashboard
      );
    },
  ),
),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => EditSppPage(
                              ListData: {
                                "id": _listdata[index]['id'],
                                "tahun": _listdata[index]['tahun'],
                                "nominal": _listdata[index]['nominal'],
                              },
                            )),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(_listdata[index]['tahun']),
                    subtitle: Text(_listdata[index]['nominal']),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  content:
                                      Text("Anda Yakin Ingin Menghapus Data ?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Batal")),
                                    ElevatedButton(
                                        onPressed: () {
                                          _hapus(_listdata[index]['tahun'])
                                              .then((value) {
                                            if (value) {
                                              final snackBar = SnackBar(
                                                content: const Text(
                                                    'Data Berhasil di Hapus'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              final snackBar = SnackBar(
                                                content: const Text(
                                                    'Data Gagal di Hapus'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          });
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      DataSppPage())),
                                              (route) => false);
                                        },
                                        child: Text("Hapus"))
                                  ],
                                );
                              }));
                        },
                        icon: Icon(Icons.delete)),
                  ),
                ));
              }),
            ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 25),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => TambahSppPage())));
        },
      ),
    );
  }
}

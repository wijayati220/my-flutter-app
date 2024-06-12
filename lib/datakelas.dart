import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'editdatakelas.dart';
import 'tambahdatakelas.dart';

class DataKelasPage extends StatefulWidget {
  const DataKelasPage({Key? key}) : super(key: key);

  @override
  _DataKelasPageState createState() => _DataKelasPageState();
}

class _DataKelasPageState extends State<DataKelasPage> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.161.140/spp_login_signup/readkelas.php'));
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
          Uri.parse('http://192.168.161.140/spp_login_signup/hapuskelas.php'),
          body: {
            "nama_kelas": id,
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
  title: const Text('Data Kelas'),
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
                        builder: ((context) => EditKelasPage(
                              ListData: {
                                "id": _listdata[index]['id'],
                                "nama_kelas": _listdata[index]['nama_kelas'],
                                "kompetensi_keahlian": _listdata[index]['kompetensi_keahlian'],
                              },
                            )),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(_listdata[index]['nama_kelas']),
                    subtitle: Text(_listdata[index]['kompetensi_keahlian']),
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
                                          _hapus(_listdata[index]['nama_kelas'])
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
                                                      DataKelasPage())),
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
              MaterialPageRoute(builder: ((context) => TambahKelasPage())));
        },
      ),
    );
  }
}

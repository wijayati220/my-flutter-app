import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'editdatasiswa.dart';
import 'tambahdatasiswa.dart';

class DataSiswaPage extends StatefulWidget {
  const DataSiswaPage({Key? key}) : super(key: key);

  @override
  _DataSiswaPageState createState() => _DataSiswaPageState();
}

class _DataSiswaPageState extends State<DataSiswaPage> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.161.140/spp_login_signup/readsiswa.php'));
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
          Uri.parse('http://192.168.161.140/spp_login_signup/hapussiswa.php'),
          body: {
            "nisn": id,
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
  title: const Text('Data Siswa'),
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
                        builder: ((context) => EditDataPage(
                              ListData: {
                                "id": _listdata[index]['id'],
                                "nisn": _listdata[index]['nisn'],
                                "nis": _listdata[index]['nis'],
                                "nama": _listdata[index]['nama'],
                                "id_kelas": _listdata[index]['id_kelas'],
                                "nomor_telp": _listdata[index]['nomor_telp'],
                                "alamat": _listdata[index]['alamat'],
                                "id_spp": _listdata[index]['id_spp'],
                              },
                            )),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(_listdata[index]['nama']),
                    subtitle: Text(_listdata[index]['nisn']),
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
                                          _hapus(_listdata[index]['nisn'])
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
                                                      DataSiswaPage())),
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
              MaterialPageRoute(builder: ((context) => TambahDataPage())));
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'editdatauser.dart';
import 'tambahdatauser.dart';

class DataUserPage extends StatefulWidget {
  const DataUserPage({Key? key}) : super(key: key);

  @override
  _DataUserPageState createState() => _DataUserPageState();
}

class _DataUserPageState extends State<DataUserPage> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.161.140/spp_login_signup/readuser.php'));
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
          Uri.parse('http://192.168.100.43/spp_login_signup/hapususer.php'),
          body: {
            "name": id,
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
        title: const Text('Data User'),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 138, 251),
                Color.fromARGB(255, 64, 232, 251),
              ],
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
              MaterialPageRoute(builder: (context) => DashBoard()),
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
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => EditUserPage(
                                ListData: {
                                  "id": _listdata[index]['id'],
                                  "name": _listdata[index]['name'],
                                  "email": _listdata[index]['email'],
                                  "password": _listdata[index]['password'],
                                  "level": _listdata[index]['level'],
                                },
                              )),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                        backgroundColor: Colors.blue,
                      ),
                      title: Text(_listdata[index]['name']),
                      subtitle: Text(_listdata[index]['email']),
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
                                    child: Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _hapus(_listdata[index]['name'])
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
                                              DataUserPage()),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text("Hapus"),
                                  )
                                ],
                              );
                            }),
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 25),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => TambahUserPage())));
        },
      ),
    );
  }
}

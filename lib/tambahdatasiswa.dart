import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datasiswa.dart';

class TambahDataPage extends StatefulWidget {
  TambahDataPage({Key? key}) : super(key: key);

  @override
  State<TambahDataPage> createState() => _TambahDataPageState();
}

class _TambahDataPageState extends State<TambahDataPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nisn = TextEditingController();
  TextEditingController nis = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController id_kelas = TextEditingController();
  TextEditingController nomor_telp = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController id_spp = TextEditingController();

  Future<bool> _simpan() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.161.140/spp_login_signup/createsiswa.php'),
        body: {
          "nisn": nisn.text,
          "nis": nis.text,
          "nama": nama.text,
          "id_kelas": id_kelas.text,
          "nomor_telp": nomor_telp.text,
          "alamat": alamat.text,
          "id_spp": id_spp.text,
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
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
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: nisn,
                decoration: InputDecoration(
                  hintText: "Nisn",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nisn tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nis,
                decoration: InputDecoration(
                  hintText: "Nis",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nis tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  hintText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: id_kelas,
                decoration: InputDecoration(
                  hintText: "Kelas",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Kelas tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nomor_telp,
                decoration: InputDecoration(
                  hintText: "No.Telp",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "No.Telp tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  hintText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alamat tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: id_spp,
                decoration: InputDecoration(
                  hintText: "SPP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "SPP tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) {
                      if(value) {
                        final snackBar = SnackBar(
                        content: const Text('Data Berhasil di Simpan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else {
                        final snackBar = SnackBar(
                        content: const Text('Data Gagal di Simpan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => DataSiswaPage())),
                        (route) => false);

                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

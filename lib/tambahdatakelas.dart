import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datakelas.dart';

class TambahKelasPage extends StatefulWidget {
  TambahKelasPage({Key? key}) : super(key: key);

  @override
  State<TambahKelasPage> createState() => _TambahKelasPageState();
}

class _TambahKelasPageState extends State<TambahKelasPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_kelas = TextEditingController();
  TextEditingController kompetensi_keahlian = TextEditingController();
  Future<bool> _simpan() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.161.140/spp_login_signup/createkelas.php'),
        body: {
          "nama_kelas": nama_kelas.text,
          "kompetensi_keahlian": kompetensi_keahlian.text,
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
        title: Text("Tambah Data Kelas"),
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
                controller: nama_kelas,
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
                controller: kompetensi_keahlian,
                decoration: InputDecoration(
                  hintText: "Kompetensi Keahlian",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Kompetensi Keahlian tidak boleh kosong";
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
                        builder: ((context) => DataKelasPage())),
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

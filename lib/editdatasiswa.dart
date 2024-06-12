import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datasiswa.dart';

class EditDataPage extends StatefulWidget {
  final Map ListData;
  EditDataPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nisn = TextEditingController();
  TextEditingController nis = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController id_kelas = TextEditingController();
  TextEditingController nomor_telp = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController id_spp = TextEditingController();

  Future<bool> _update() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.161.140/spp_login_signup/editsiswa.php'),
        body: {
          "id": id.text,
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
    id.text=widget.ListData['id'];
    nisn.text=widget.ListData['nisn'];
    nis.text=widget.ListData['nis'];
    nama.text=widget.ListData['nama'];
    id_kelas.text=widget.ListData['id_kelas'];
    nomor_telp.text=widget.ListData['nomor_telp'];
    alamat.text=widget.ListData['alamat'];
    id_spp.text=widget.ListData['id_spp'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
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
                    _update().then((value) {
                      if(value) {
                        final snackBar = SnackBar(
                        content: const Text('Data Berhasil di Update'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else {
                        final snackBar = SnackBar(
                        content: const Text('Data Gagal di Update'),
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
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

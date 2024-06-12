import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datapembayaran.dart';

class TambahPembayaranPage extends StatefulWidget {
  TambahPembayaranPage({Key? key}) : super(key: key);

  @override
  State<TambahPembayaranPage> createState() => _TambahPembayaranPageState();
}

class _TambahPembayaranPageState extends State<TambahPembayaranPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_user = TextEditingController();
  TextEditingController id_siswa = TextEditingController();
  TextEditingController spp_bulan = TextEditingController();
  TextEditingController jumlah_bayar = TextEditingController();

  Future<bool> _simpan() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.161.140/spp_login_signup/createpembayaran.php'),
        body: {
          "id_user": id_user.text,
          "id_siswa": id_siswa.text,
          "spp_bulan": spp_bulan.text,
          "jumlah_bayar": jumlah_bayar.text,
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
        title: Text("Tambah Data Pembayaran"),
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
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
         children: [
              TextFormField(
                controller: id_user,
                decoration: InputDecoration(
                  hintText: "id user",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "id_user tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: id_siswa,
                decoration: InputDecoration(
                  hintText: "id_siswa",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "id_siswa tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: spp_bulan,
                decoration: InputDecoration(
                  hintText: "spp_bulan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "spp_bulan tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jumlah_bayar,
                decoration: InputDecoration(
                  hintText: "jumlah_bayar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "jumlah bayar tidak boleh kosong";
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
                        builder: ((context) => DataPembayaranPage())),
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dataspp.dart';

class EditSppPage extends StatefulWidget {
  final Map ListData;
  EditSppPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditSppPage> createState() => _EditSppPageState();
}

class _EditSppPageState extends State<EditSppPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController tahun = TextEditingController();
  TextEditingController nominal = TextEditingController();
  Future<bool> _update() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.161.140/spp_login_signup/editspp.php'),
        body: {
          "id": id.text,
          "tahun": tahun.text,
          "nominal": nominal.text,
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
    tahun.text=widget.ListData['tahun'];
    nominal.text=widget.ListData['nominal'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data SPP"),
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
                controller: tahun,
                decoration: InputDecoration(
                  hintText: "Tahun",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tahun tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nominal,
                decoration: InputDecoration(
                  hintText: "Nominal",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nominal tidak boleh kosong";
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
                        builder: ((context) => DataSppPage())),
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

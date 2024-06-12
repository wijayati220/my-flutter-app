import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datauser.dart';

class EditUserPage extends StatefulWidget {
  final Map ListData;
  EditUserPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController level = TextEditingController();

  Future<bool> _update() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.161.140/spp_login_signup/edituser.php'),
        body: {
          "id": id.text,
          "name": name.text,
          "email": email.text,
          "password": password.text,
          "level": level.text,
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
    name.text=widget.ListData['name'];
    email.text=widget.ListData['email'];
    password.text=widget.ListData['password'];
    level.text=widget.ListData['level'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data User"),
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
                controller: name,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: level,
                decoration: InputDecoration(
                  hintText: "Level",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Level tidak boleh kosong";
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
                        builder: ((context) => DataUserPage())),
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

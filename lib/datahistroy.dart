import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';

class DataHistoryPage extends StatefulWidget {
  const DataHistoryPage({Key? key}) : super(key: key);

  @override
  _DataHistoryPageState createState() => _DataHistoryPageState();
}

class _DataHistoryPageState extends State<DataHistoryPage> {
  List<dynamic> _listPembayaran = [];
  List<dynamic> _listSiswa = [];
  List<dynamic> _listKelas = [];
  bool _isLoading = false;

  Future<void> _getData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.161.140/spp_login_signup/readpembayaran.php'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listPembayaran = data['pembayaran'];
          _listSiswa = data['siswa'];
          _listKelas = data['kelas'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, show error message, etc.
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Pembayaran'),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
  itemCount: _listPembayaran.length,
  itemBuilder: ((context, index) {
    if (index < _listSiswa.length && index < _listKelas.length) {
      return Card(
        child: ListTile(
          title: Text(_listSiswa[index]['nama']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jumlah Bayar: ${_listPembayaran[index]['jumlah_bayar']}'),
              Text('Kelas: ${_listKelas[index]['nama_kelas']}'),
              Text('Waktu Pembayaran: ${_listPembayaran[index]['created_at']}'),
            ],
          ),
        ),
      );
    } else {
      return Container(); // Atau widget kosong lainnya jika indeks melebihi panjang list
    }
  }),
),

    );
  }
}

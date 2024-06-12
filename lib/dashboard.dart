import 'package:flutter/material.dart';
import 'main.dart';
import 'datauser.dart';
import 'datasiswa.dart';
import 'datakelas.dart';
import 'dataspp.dart';
import 'datapembayaran.dart';
import 'datahistroy.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard), // Tambahkan ikon di sini
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                // Navigasi ke halaman Dashboard
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Data Siswa'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataSiswaPage()),
                );
              },
),
            ListTile(
              leading: Icon(Icons.people), // Tambahkan ikon di sini
              title: const Text('Data User'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataUserPage()),
                );
                // Navigasi ke halaman Data User
              },
            ),
            ListTile(
              leading: Icon(Icons.class_), // Tambahkan ikon di sini
              title: const Text('Data Kelas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataKelasPage()),
                );
                // Navigasi ke halaman Data Kelas
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money), // Tambahkan ikon di sini
              title: const Text('Data SPP'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataSppPage()),
                );
                // Navigasi ke halaman Data SPP
              },
            ),
            ListTile(
              leading: Icon(Icons.payment), // Tambahkan ikon di sini
              title: const Text('Pembayaran'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataPembayaranPage()),
                );
                // Navigasi ke halaman Pembayaran
              },
            ),
            ListTile(
              leading: Icon(Icons.history), // Tambahkan ikon di sini
              title: const Text('History Pembayaran'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataHistoryPage()),
                );
                // Navigasi ke halaman History Pembayaran
              },
            ),
            ListTile(
              leading: Icon(Icons.report), // Tambahkan ikon di sini
              title: const Text('Laporan Pembayaran'),
              onTap: () {
                Navigator.pop(context);
                // Navigasi ke halaman Laporan Pembayaran
              },
            ),
            ListTile(
              leading: Icon(Icons.logout), // Tambahkan ikon di sini
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                // Tambahkan logika untuk logout di sini
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Dashboard')),
    );
  }
}

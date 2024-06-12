import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/firebase_options.dart';
import 'login.dart';
import 'login_option.dart';
import 'signup.dart';
import 'signup_option.dart';
import 'splashScreen.dart';
import 'datakelas.dart';
import 'datauser.dart';
import 'datasiswa.dart';
import 'dataspp.dart';
import 'datapembayaran.dart';
import 'datahistroy.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: GoogleFonts.muktaVaaniTextTheme(), // Hapus baris ini
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Mengarahkan ke splash screen sebagai halaman pertama
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const Login(),
        '/data-siswa': (context) => const DataSiswaPage(),
        '/data-user': (context) => const DataUserPage(),
        '/data-kelas': (context) => const DataKelasPage(),
        '/data-spp': (context) => const DataSppPage(),
        '/data-pembayaran': (context) => const DataPembayaranPage(),
        '/data-history': (context) => const DataHistoryPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            GestureDetector(
              onTap: () {
                setState(() {
                  login = true;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(login),
                  child: Container(
                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: login 
                          ? const Login()
                          : const LoginOption(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  login = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.6,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: login ? 55 : 0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: !login 
                        ? SignUp()
                        : const SignUpOption(),
                      ),
                    ),
                  )
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.shader = const RadialGradient(
      colors: [
        Color.fromARGB(255, 0, 138, 251),
        Color.fromARGB(255, 64, 232, 251),
      ],
    ).createShader(Rect.fromCircle(
      radius: 600, center: const Offset(50, 50),
    ));
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

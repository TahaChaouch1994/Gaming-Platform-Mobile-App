import 'package:flutter/material.dart';
import 'package:geeks_overflow/views/home/home.dart';
import 'package:geeks_overflow/views/login/loginPage.dart';
import 'package:geeks_overflow/views/tournament/brackettournament.dart';
import 'package:geeks_overflow/views/tournament/myaccepted.dart';
import 'package:geeks_overflow/views/tournament/myaccepteddetail.dart';
import 'package:geeks_overflow/views/tournament/tournamentdetail.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp(

));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //WidgetsFlutterBinding.ensureInitialized();
  //_appDocsDir = await getApplicationDocumentsDirectory();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(

      title: 'GeeksOverFlow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(textStyle: textTheme.bodyText2),
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: LoginPage(),

      routes: {
        '/tournamentdetail': (context) => Tournamentdetail(),
        '/myaccepted': (context) => MyAccepted(),
        '/myaccepteddetail': (context) => MyAcceptedDetail(),
        '/bracket': (context) => bracketTournament(),
      },
    );

  }
}

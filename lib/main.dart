import 'package:flutter/material.dart';
import 'package:widget_ppb/finance_list.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp(), theme: _buildTheme(Brightness.light)));
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    primaryColor: Colors.blueAccent,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTheme.textTheme),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Financial Application',
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Colors.white70,
              letterSpacing: 1.0,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Expanded(child: FinanceList())],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:widget_ppb/finance.dart';
import 'package:widget_ppb/finance_list.dart';
import 'package:widget_ppb/finance_overview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_ppb/type_enum.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void main() => runApp(
  MaterialApp(home: MyApp(), theme: _buildTheme(Brightness.light)),
);

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    primaryColor: Colors.blueAccent,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTheme.textTheme),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Financial Application',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 25.0,
              color: Colors.white70,
              letterSpacing: 2.0,
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
          children: [
            Expanded(
              child: FinanceList(),
            ),
          ],
        ),
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_ppb/finance.dart';
import 'package:widget_ppb/finance_card.dart';
import 'package:widget_ppb/finance_overview.dart';
import 'package:widget_ppb/finance_statistic.dart';
import 'package:widget_ppb/type_enum.dart';

class FinanceList extends StatefulWidget {
  const FinanceList({super.key});

  @override
  State<FinanceList> createState() => _FinanceListState();
}

class _FinanceListState extends State<FinanceList> {
  List<Finance> finances = [
    Finance(
      id: 1,
      name: 'Beli makan',
      amount: 15000.00,
      type: FinanceType.food,
    ),
    Finance(id: 2, name: 'Beli minum', amount: 5000.00, type: FinanceType.food),
    Finance(
      id: 3,
      name: 'Bayar UKT',
      amount: 3000000.00,
      type: FinanceType.education,
    ),
    Finance(
      id: 4,
      name: 'Beli buku',
      amount: 150000.00,
      type: FinanceType.entertainment,
    ),
    Finance(
      id: 5,
      name: 'Beli baju',
      amount: 15000.00,
      type: FinanceType.shopping,
    ),
    Finance(
      id: 6,
      name: 'Beli makan',
      amount: 15000.00,
      type: FinanceType.food,
    ),
    Finance(
      id: 7,
      name: 'Beli bensin',
      amount: 55000.00,
      type: FinanceType.transport,
    ),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  FinanceType _selectedType = FinanceType.income;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FinanceOverview(
              totalAmount: finances.fold(0, (sum, item) => sum + item.amount),
            ),
            FinanceStatistic(finances: finances),
            SizedBox(height: 5.0),
            Text(
              'Finance Record',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  openCreateDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Buat Data Baru',
                  style: GoogleFonts.tektur(
                    textStyle: TextStyle(fontSize: 16),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: finances.length,
                itemBuilder: (context, index) {
                  return FinanceCard(
                    finance: finances[index],
                    delete: () {
                      setState(() {
                        finances.removeAt(index);
                      });
                    },
                    edit: () {
                      openEditDialog(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openCreateDialog() => showDialog(
    context: context,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                'Buat data baru',
                style: GoogleFonts.tektur(textStyle: TextStyle(fontSize: 16)),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Masukkan Nama Pencatatan',
                    ),
                  ),
                  TextField(
                    controller: _amountController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Besaran Uang'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pilih Tipe Pencatatan',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownButton<FinanceType>(
                    value: _selectedType,
                    isExpanded: true,
                    onChanged: (FinanceType? newValue) {
                      setState(() {
                        _selectedType = newValue!;
                      });
                    },
                    items:
                        FinanceType.values.map((FinanceType type) {
                          return DropdownMenuItem<FinanceType>(
                            value: type,
                            child: Text(
                              type.toString().split('.').last,
                            ), // Hanya ambil nama enum
                          );
                        }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cancel, color: Colors.redAccent),
                      SizedBox(width: 5),
                      Text('Cancel', style: TextStyle(color: Colors.redAccent)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    double? amount = double.tryParse(_amountController.text);
                    if (_nameController.text.isNotEmpty && amount != null) {
                      setState(() {
                        finances.add(
                          Finance(
                            id: finances.length + 1,
                            name: _nameController.text,
                            amount: amount,
                            type: _selectedType,
                          ),
                        );
                      });

                      _nameController.clear();
                      _amountController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Berhasil menambahkan data"),
                          backgroundColor: Colors.green.shade300,
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Mohon isi nama dan jumlah dengan benar",
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.blue),
                      SizedBox(width: 5),
                      Text('Create', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
  );

  Future openEditDialog(int index) {
    Finance finance = finances[index];
    _nameController.text = finance.name;
    _amountController.text = finance.amount.toString();
    _selectedType = finance.type;

    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Ubah Data',
              style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 18)),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nama Pencatatan'),
                ),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(labelText: 'Besaran Uang'),
                ),
                SizedBox(height: 10),
                Text(
                  'Pilih Tipe Pencatatan',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton<FinanceType>(
                  value: _selectedType,
                  isExpanded: true,
                  onChanged: (FinanceType? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                  items:
                      FinanceType.values.map((FinanceType type) {
                        return DropdownMenuItem<FinanceType>(
                          value: type,
                          child: Text(type.toString().split('.').last),
                        );
                      }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cancel, color: Colors.redAccent),
                    SizedBox(width: 5),
                    Text('Cancel', style: TextStyle(color: Colors.redAccent)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  double? amount = double.tryParse(_amountController.text);
                  if (_nameController.text.isNotEmpty && amount != null) {
                    setState(() {
                      finances[index] = Finance(
                        id: finance.id,
                        name: _nameController.text,
                        amount: amount,
                        type: _selectedType,
                      );
                    });

                    _nameController.clear();
                    _amountController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Berhasil menambahkan data"),
                        backgroundColor: Colors.green.shade300,
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Mohon isi nama dan jumlah dengan benar"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, color: Colors.white),
                      SizedBox(width: 5),
                      Text('Edit Data', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

import 'package:widget_ppb/type_enum.dart';

class Finance {
  final int id;
  final String name;
  final double amount;
  final FinanceType type;

  Finance(
      {required this.id, required this.name, required this.amount, required this.type});

  factory Finance.fromJson(Map<String, dynamic> json){
    return Finance(id: json['id'] as int,
        name: json['name'],
        amount: (json['amount'] as num).toDouble(),
        type: FinanceType.values.firstWhere((e) => e.toString() == 'FinanceType.${json['type']}')
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }

}
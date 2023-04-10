import 'package:flutter/material.dart';

class FinanceScreen extends StatefulWidget {
  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  String? _selectedProduct;
  String? _customerName;
  double? _amount;
  double? _downPayment;

  final List<String> _products = [
    'Car',
    'Motorcycle',
    'Boat',
    'RV',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: Text('Finance'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButton(
              value: _selectedProduct,
              onChanged: (newValue) {
                setState(() {
                  _selectedProduct = newValue;
                });
              },
              items: _products.map((product) {
                return DropdownMenuItem(
                  value: product,
                  child: Text(product),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Customer Information:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _customerName = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Amount:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _amount = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
                prefixText: '\$',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Down Payment:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _downPayment = double.parse(value);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Down Payment',
                prefixText: '\$',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

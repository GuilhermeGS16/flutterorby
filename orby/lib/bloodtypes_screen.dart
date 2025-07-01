import 'package:flutter/material.dart';

class BloodTypesScreen extends StatelessWidget {
  const BloodTypesScreen({super.key});

  Widget _buildTable(String bloodType, List<String> recebeDe, List<String> doaPara) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFCD3232),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                bloodType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('RECEBE DE', style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('DOA PARA', style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(recebeDe.join(', '))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(doaPara.join(', '))),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tipos Sanguíneos'),
        backgroundColor: const Color(0xFFCD3232),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildTable('A+', ['A-', 'A+', 'O-', 'O+'], ['A+', 'AB+']),
          _buildTable('B+', ['B-', 'B+', 'O-', 'O+'], ['B+', 'AB+']),
          _buildTable('AB+', ['Todos'], ['AB+']),
          _buildTable('O+', ['O-', 'O+'], ['A+', 'B+', 'AB+', 'O+']),
          _buildTable('A-', ['A-', 'O-'], ['A-', 'A+', 'AB-', 'AB+']),
          _buildTable('B-', ['B-', 'O-'], ['B-', 'B+', 'AB-', 'AB+']),
          _buildTable('AB-', ['A-', 'B-', 'AB-', 'O-'], ['AB-', 'AB+']),
          _buildTable('O-', ['O-'], ['Todos']),
        ],
      ),
    );
  }
}
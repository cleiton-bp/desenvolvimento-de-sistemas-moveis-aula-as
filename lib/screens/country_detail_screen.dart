import 'package:autentocacao/models/Countrie.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final Countrie countrie;

  const CountryDetailScreen({Key? key, required this.countrie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        title: Text(
          'Detalhes do País',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  countrie.flagPng,
                  width: 150,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                countrie.commonName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDetailRow(
                Icons.flag,
                'Nome Oficial',
                countrie.officialName,
              ),
              _buildDetailRow(
                  Icons.location_city,
                  'Capital',
                  countrie.capital.isNotEmpty
                      ? countrie.capital.join(", ")
                      : "Sem capital"),
              _buildDetailRow(
                Icons.map,
                'Região',
                countrie.region,
              ),
              _buildDetailRow(
                Icons.place,
                'Sub-região',
                countrie.subregion,
              ),
              _buildDetailRow(
                Icons.people,
                'População',
                countrie.population.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

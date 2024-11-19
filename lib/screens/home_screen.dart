import 'package:autentocacao/models/Countrie.dart';
import 'package:autentocacao/services/auth_service.dart';
import 'package:autentocacao/services/countrie_service.dart';
import 'package:autentocacao/widgets/home/country_card.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.authService}) : super(key: key);

  final String title;
  final AuthService authService;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Countrie>> futureCountries;
  List<Countrie> _allCountries = [];
  List<Countrie> _filteredCountries = [];
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    futureCountries = CountrieService().getCountries();
    futureCountries.then((countries) {
      setState(() {
        _allCountries = countries;
        _filteredCountries = countries;
      });
    });
  }

  void _filterCountries(String searchText) {
    setState(() {
      _searchText = searchText;
      if (_searchText.isEmpty) {
        _filteredCountries = _allCountries;
      } else {
        _filteredCountries = _allCountries.where((countrie) {
          return countrie.commonName.toLowerCase().contains(searchText.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.authService.logout(context);
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Pesquisar por nome do país',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterCountries,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Countrie>>(
              future: futureCountries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: _filteredCountries.length,
                    itemBuilder: (context, index) {
                      Countrie countrie = _filteredCountries[index];
                      // Envolvendo CountryCard em uma animação
                      return BounceInDown(
                        duration: const Duration(milliseconds: 700),
                        delay: Duration(milliseconds: index * 2),
                        child: CountryCard(countrie: countrie),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Nenhum país encontrado'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
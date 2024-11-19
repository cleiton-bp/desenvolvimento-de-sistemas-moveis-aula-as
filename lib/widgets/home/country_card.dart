import 'package:autentocacao/models/Countrie.dart';
import 'package:autentocacao/screens/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';


class CountryCard extends StatelessWidget {
  final Countrie countrie;

  const CountryCard({Key? key, required this.countrie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 500),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: ListTile(
          leading: Image.network(
            countrie.flagPng,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(
            countrie.commonName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Capital: ${countrie.capital.isNotEmpty ? countrie.capital.join(", ") : "Sem capital"}',
              ),
              Text('Região: ${countrie.region}'),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => CountryDetailScreen(countrie: countrie),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
class Countrie {
  final String commonName;
  final String officialName;
  final List<String> capital;
  final int population;
  final String flagPng;
  final String flagSvg;
  final String region;
  final String subregion;

  const Countrie({
    required this.commonName,
    required this.officialName,
    required this.capital,
    required this.population,
    required this.flagPng,
    required this.flagSvg,
    required this.region,
    required this.subregion,
  });

  factory Countrie.fromJson(Map<String, dynamic> json) {
    return Countrie(
      commonName: json['name']['common'],
      officialName: json['name']['official'],
      capital: json['capital'] != null ? List<String>.from(json['capital']) : [],
      population: json['population'],
      flagPng: json['flags']['png'],
      flagSvg: json['flags']['svg'],
      region: json['region'],
      subregion: json['subregion'] ?? 'Unknown',
    );
  }
}
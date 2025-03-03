import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikave pro výpočet spotřeby',
      home: HomeScreen(), // novy widget pro zobrazeni main obrazovky
    );
  }
}

//nový widget pro main obrazovku
class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState() {
   super.initState();
   WidgetsBinding.instance.addPostFrameCallback((_) {_showWelcomeDialog();
   });
  }


void _showWelcomeDialog() {
  var context;
  showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Vítejte v aplikaci"),
          content: const Text("Přijde mi užitečnější apliakce pro výpočet spotřeby"),
          actions: [
            TextButton(
                onPressed: () {Navigator.of(context).pop();},
                child: const Text("Ok"),
            ),
          ],
        );
      },
  );
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplikace pro výpočet spotřeby"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
              child: VypocetSpotreby(),
      ),
    );
  }
}

class VypocetSpotreby extends StatefulWidget {
  @override
    _VypocetSpotrebyState createState() => _VypocetSpotrebyState();
}

class _VypocetSpotrebyState extends State<VypocetSpotreby> { //Controllery ukádají data dulezite pro vypocet
  final TextEditingController vzdalenostController = TextEditingController();
  final TextEditingController cenaPalivaController = TextEditingController();
  final TextEditingController prumernaSpotrebaController = TextEditingController();
  String vysledek = '';
  
  void pocitaniSpotreby() { //prevod textu (Stringu) na cislo (double)
    final vzdalenost = double.tryParse(vzdalenostController.text);
    final cenaPaliva = double.tryParse(cenaPalivaController.text);
    final prumernaSpotreba = double.tryParse(prumernaSpotrebaController.text);
    
    if (vzdalenost != null && cenaPaliva != null && prumernaSpotreba != null) {
      final pouzitePalivo = (vzdalenost * prumernaSpotreba) / 100; // Vypocet spotreby paliva
      final konecnaCena = pouzitePalivo * cenaPaliva; // Vypocet nakladu
      setState(() {
        vysledek = 'Celková cena: ${konecnaCena.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        vysledek = 'Chyba: zadejte platná čísla';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        TextField(
          controller: vzdalenostController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Vzdálenost (km)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: cenaPalivaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Cena paliva (Kč/l)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: prumernaSpotrebaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Průměrná spotřeba (l/100 km)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
            onPressed: pocitaniSpotreby,
            child: Text("Vypočítat!")
        ),
        SizedBox(height: 16),
        Text('Výsledek:\n$vysledek', style: TextStyle(fontSize: 18),)
      ],
    );
  }
}


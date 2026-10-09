import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final _textFieldController = TextEditingController();

  void _navigateToResultPage(BuildContext context) {
    String value = _textFieldController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(value: value),
      ),
    );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Récupérer le contenu d'un TextField",
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Champ de saisie
            Container(
              width: 400,
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _textFieldController,
                autocorrect: true,
                decoration: const InputDecoration(
                  hintText: 'Écrivez du texte ici',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),

            // Bouton de navigation
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 23, 58, 255),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                _navigateToResultPage(context);
              },
              child: const Text(
                'Cliquez ici pour récupérer les données saisies',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String value;

  const ResultPage({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Page'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Text(
          'Data from TextField: $value',
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
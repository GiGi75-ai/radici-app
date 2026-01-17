import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(RadiciApp());

class RadiciApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}

// --- 0. SCHERMATA DI BENVENUTO ---
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, size: 80, color: Colors.blueAccent),
            SizedBox(height: 30),
            Text("RADICI", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 5)),
            SizedBox(height: 20),
            Text(
              "Oggi è un altro giorno... il tuo giorno.\n\nQuesta app è stata creata per essere chiusa. Sei pronto a sbucciarti le ginocchia?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey[300]),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
              child: Text("ACCETTO LA SFIDA"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeOne())),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 1. LIVELLO 1: IL PANINO ---
class ChallengeOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Livello 1: Risveglio")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("SFIDA: L'Attesa del Pane", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Vai in un forno o da un salumiere. Compra qualcosa osservando chi lavora. Vietato l'uso del telefono.", style: TextStyle(fontSize: 18)),
            Spacer(),
            ElevatedButton(
              child: Text("HO COMPLETATO LA SFIDA"),
              onPressed: () => _mostraVerifica(context),
            ),
          ],
        ),
      ),
    );
  }

  void _mostraVerifica(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Verifica Umana"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Di che colore era la divisa di chi ti ha servito?"),
            TextField(decoration: InputDecoration(hintText: "Scrivi il colore...")),
          ],
        ),
        actions: [
          TextButton(child: Text("NON SONO ANDATO"), onPressed: () {
            Navigator.pop(context);
            _mostraBacchettata(context);
          }),
          ElevatedButton(child: Text("CONFERMA"), onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeTwo()));
          }),
        ],
      ),
    );
  }

  void _mostraBacchettata(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red[900],
        title: Text("ATTENZIONE"),
        content: Text("Stai imbrogliando te stesso. Torna quando avrai le scarpe sporche di polvere."),
        actions: [TextButton(child: Text("RIPROVERÒ", style: TextStyle(color: Colors.white)), onPressed: () => Navigator.pop(context))],
      ),
    );
  }
}

// --- 2. LIVELLO 2: LA MEMORIA ---
class ChallengeTwo extends StatefulWidget {
  @override
  _ChallengeTwoState createState() => _ChallengeTwoState();
}

class _ChallengeTwoState extends State<ChallengeTwo> {
  bool _mostraNumero = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Livello 2: Backup Umano")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("SFIDA: Memoria di Ferro", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Memorizza questo numero. Hai 10 secondi. Scrivilo su carta e portalo con te.", style: TextStyle(fontSize: 18)),
            SizedBox(height: 40),
            if (!_mostraNumero)
              ElevatedButton(
                child: Text("VEDI NUMERO (10 SEC)"),
                onPressed: () {
                  setState(() => _mostraNumero = true);
                  Timer(Duration(seconds: 10), () {
                    if (mounted) setState(() => _mostraNumero = false);
                  });
                },
              ),
            if (_mostraNumero)
              Text("06 0606", style: TextStyle(fontSize: 40, color: Colors.yellow, fontWeight: FontWeight.bold)),
            Spacer(),
            Text("L'aiuto migliore viene da te stesso!", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("FATTO, VAI AL LIVELLO 3"), 
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeThree()));
              }
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. LIVELLO 3: LA BUSSOLA ---
class ChallengeThree extends StatefulWidget {
  @override
  _ChallengeThreeState createState() => _ChallengeThreeState();
}

class _ChallengeThreeState extends State<ChallengeThree> {
  bool _orientato = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Livello 3: La Bussola")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("SFIDA: Trova la Rotta", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(
              "Guarda il sole o i punti di riferimento. Orienta il telefono verso NORD (clicca sulla bussola per confermare).",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () => setState(() => _orientato = true),
              child: Icon(
                Icons.explore,
                size: 150,
                color: _orientato ? Colors.green : Colors.redAccent,
              ),
            ),
            SizedBox(height: 20),
            Text(_orientato ? "NORD AGGANCIATO!" : "CERCA IL NORD...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Spacer(),
            Text("Ricordati di credere in te stesso e volerti bene", 
                 style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent)),
            SizedBox(height: 20),
            if (_orientato)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                child: Text("SFIDA COMPLETATA"),
                onPressed: () => _vittoriaFinale(context),
              ),
          ],
        ),
      ),
    );
  }

  void _vittoriaFinale(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Traguardo Raggiunto"),
        content: Text("Hai completato il primo addestramento di RADICI.\n\nOggi hai usato i tuoi occhi, la tua memoria e il tuo orientamento. Sei un po' più umano di ieri."),
        actions: [
          ElevatedButton(
            child: Text("CHIUDI L'APP E VIVI"),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
      ),
    );
  }
}

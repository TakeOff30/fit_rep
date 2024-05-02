import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIcon = 3; // 3: weekly kcal selezionato di default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                'Weekly Statistics',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50), // Spazio tra il titolo e il riquadro informativo
            Center(
              child: Container(
                width: 300,
                height: 260,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  border: Border.all(color: const Color(0xFFC0C0C0), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          _buildIconSection(Icons.emoji_events, '3', true, true),
                          _buildIconSection(Icons.fitness_center, '0/3', false, true),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          _buildIconSection(Icons.local_fire_department, 'XXX KCAL', true, false),
                          _buildIconSection(Icons.timer, 'XXX MIN', false, false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80), // Spazio tra il riquadro informativo e le icone interattive
            _buildIconRow(), // Costruisce la fila delle icone interattive
          ],
        ),
      ),
    );
  }

  // Fila delle icone interattive per grafici
  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _iconButton(3, Icons.local_fire_department, 'Weekly kcal'),
        _iconButton(1, Icons.trending_up, 'Level'),
        _iconButton(2, Icons.fitness_center, 'Muscles'),
      ],
    );
  }

  // Icone grafici interattive
  Widget _iconButton(int id, IconData icon, String label) {
    bool isSelected = _selectedIcon == id;
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(icon, size: 40),
          color: isSelected ? const Color(0xFF39FF14) : const Color(0xFFC0C0C0),
          onPressed: () {
            setState(() {
              _selectedIcon = _selectedIcon == id ? 0 : id;
            });
          },
        ),
        if (isSelected)
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
      ],
    );
  }

  // Icone e testo del riquadro informativo
  Widget _buildIconSection(IconData icon, String label, bool borderRight, bool borderBottom) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: borderRight ? const BorderSide(width: 2, color: Color(0xFFC0C0C0)) : BorderSide.none,
            bottom: borderBottom ? const BorderSide(width: 2, color: Color(0xFFC0C0C0)) : BorderSide.none,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 32, color: const Color(0xFF39FF14)),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Roboto')),
            ],
          ),
        ),
      ),
    );
  }
}
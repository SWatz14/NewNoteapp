import 'package:flutter/material.dart';
import 'note.dart';
import 'new_note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Note App',
      theme: ThemeData(
        // Primary color
        primaryColor: Colors.deepPurple, // Set a deep purple primary color

        // Color scheme for the rest of the UI
        colorScheme: ColorScheme.light(
          primary: Colors.deepPurple, // Primary color for widgets
          secondary: Colors.orange, // Secondary color for widgets (formerly accentColor)
        ),

        // Define the default text theme
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black87), // Text color for large display
          bodyLarge: TextStyle(color: Colors.black87),   // Body text color
          bodyMedium: TextStyle(color: Colors.black54),  // Slightly smaller body text
        ),

        // AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // Set AppBar background to deep purple
        ),

        // Floating action button style
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange, // Set FAB color to orange
        ),

        // Elevated buttons theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, // Set background color for elevated buttons
            foregroundColor: Colors.white, // Set text color for elevated buttons
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.deepPurple), // Label color in text fields
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple), // Focused border color
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List to store notes
  List<Note> notes = [];

  // Function to add new note
  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: notes.isEmpty
          ? const Center(child: Text('No notes here.'))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notes[index].title),
            subtitle: Text(notes[index].description),
            onTap: () {
              // Handle tap to edit or view note
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewNoteScreen(onNoteAdded: _addNote),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'new_note_screen.dart';
import 'note.dart';

class HomeScreen extends StatefulWidget {
  final List<Note> notes;
  final Function(Note) onNoteAdded;

  HomeScreen({Key? key, required this.notes, required this.onNoteAdded}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: widget.notes.isEmpty
          ? Center(
        child: Text(
          'No notes here.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          final note = widget.notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.of(context).push<Note>(
            MaterialPageRoute(
              builder: (context) => NewNoteScreen(onNoteAdded: widget.onNoteAdded),
            ),
          );
          if (newNote != null) {
            widget.onNoteAdded(newNote);
          }
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}

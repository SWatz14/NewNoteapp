import 'package:flutter/material.dart';
import 'note.dart';

class NewNoteScreen extends StatefulWidget {
  final Function(Note) onNoteAdded;

  const NewNoteScreen({Key? key, required this.onNoteAdded}) : super(key: key);

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  String? _errorMessage;

  // Function to save the note
  void _saveNote() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final content = _contentController.text;

    // Validation: check if both fields are filled
    if (title.isEmpty || description.isEmpty || content.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required';
      });
    } else {
      // Create a new note
      final note = Note(
        title: title,
        content: content,
        description: description,
      );

      // Add the note using the provided callback and navigate back to HomeScreen
      widget.onNoteAdded(note);
      Navigator.of(context).pop(note); // Go back to HomeScreen
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // Back arrow
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title input box
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            // Description input box
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            // Content input box (Main content of the note)
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null, // Allows for multiple lines of text
            ),
            const SizedBox(height: 16.0),
            // Display error message if any field is empty
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16.0),
            // Save button at the bottom
            ElevatedButton(
              onPressed: _saveNote, // Calls _saveNote when pressed
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

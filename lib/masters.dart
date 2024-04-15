import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:my_app/main.dart';

void main() {
  runApp(masters());
}

class masters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teachers Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TeacherListScreen(),
    );
  }
}

class TeacherListScreen extends StatefulWidget {
  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _cvPath;
  String? _imagePath;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardApp()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Action to select image file
                      _selectImageFile();
                    },
                    child: Text(_imagePath == null ? 'SELECT IMAGE' : 'IMAGE SELECTED'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Action to select CV file
                      _selectCVFile();
                    },
                    child: Text(_cvPath == null ? 'SELECT CV' : 'CV SELECTED'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Action to add teacher
                      _addTeacher();
                    },
                    child: Text('ADD TEACHER'),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // Number of teachers
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
                    child: _imagePath == null ? Text((index + 1).toString()) : null,
                  ),
                  title: Text('Teacher ${index + 1}'),
                  subtitle: Text('Email: teacher${index + 1}@example.com'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Action to edit teacher
                      _editTeacher();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imagePath = result.files.single.path!;
      });
    }
  }

  void _selectCVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _cvPath = result.files.single.path!;
      });
    }
  }

  void _addTeacher() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;

    // Check if image and CV are selected
    if (_imagePath == null || _cvPath == null) {
      // Show error message or handle the case when image or CV is not selected
      return;
    }

    // Perform further actions like adding the teacher to the list or sending the data to a server

    // Clear the text fields and reset image and CV paths after adding the teacher
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    setState(() {
      _imagePath = null;
      _cvPath = null;
    });
  }

  void _editTeacher() {
    // Action to edit the teacher
  }
}

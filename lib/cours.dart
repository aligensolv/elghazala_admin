import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/main.dart';

void main() {
  runApp(cours());
}

class cours extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courses Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CourseListScreen(),
    );
  }
}

class CourseListScreen extends StatefulWidget {
  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _professorController = TextEditingController();
  final _dateController = TextEditingController();
  final _priceController = TextEditingController();
  String _imageUrl = '';
  
  bool _isObligated = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _professorController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses List'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _professorController,
                  decoration: InputDecoration(labelText: 'Professor'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),

                Row(
                  children: [
                    Text('Is Obligated?', style: TextStyle(
                      color: Colors.black
                    ),),
                    Expanded(
                      child: Checkbox(
                                      value: _isObligated, 
                                      onChanged: (val){
                      setState(() {
                        _isObligated = val!;
                      });
                                      }
                                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _openImagePicker,
                      child: Text('Pick Image'),
                    ),
                    SizedBox(width: 10),
                    _imageUrl.isEmpty
                        ? Text('No image selected')
                        : Expanded(
                            child: Image.network(
                              _imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Action to add course
                    _addCourse();
                  },
                  child: Text('ADD COURSE'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('courses')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                     return Dismissible(
                    key: ValueKey(doc.id),
                    onDismissed: (direction) async {
                      await doc.reference.delete();
                    },
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: (){
                        _editCourse(doc.id);
                      },
                      title: Text(doc.get('title')),
                      subtitle: Text(doc.get('description')),
                    ),
                  );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addCourse() async{
    String title = _titleController.text;
    String description = _descriptionController.text;
    String professor = _professorController.text;
    String date = _dateController.text;
    String price = _priceController.text;
    
    await FirebaseFirestore.instance.collection('courses').add({
      'title': title,
      'description': description,
      'professor': professor,
      'date': date,
      'price': price,
    });


    _titleController.clear();
    _descriptionController.clear();
    _professorController.clear();
    _dateController.clear();
    _priceController.clear();
    _imageUrl = '';
  }

  void _editCourse(doc_id) {
    String _title = '';
    String _description = '';
    String _professor = '';
    String _date = '';
    String _price = '';
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Course'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: _title,
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _description,
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _professor,
                    decoration: InputDecoration(labelText: 'Professor'),
                    onChanged: (value) {
                      setState(() {
                        _professor = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _date,
                    decoration: InputDecoration(labelText: 'Date'),
                    onChanged: (value) {
                      setState(() {
                        _date = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _price,
                    decoration: InputDecoration(labelText: 'Price'),
                    onChanged: (value) {
                      setState(() {
                        _price = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                _updateCourse(
                  doc_id: doc_id,
                  title: _title,
                  description: _description,
                  professor: _professor,
                  date: _date,
                  price: _price,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }


  void _openImagePicker() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          _imageUrl = image.path;
        });
      }
    });

  }
  
  void _updateCourse({
    required String doc_id,
    required String title,
    required String description,
    required String professor,
    required String date,
    required String price,
  }) {
    FirebaseFirestore.instance.collection('courses').doc(doc_id).update({
      'title': title,
      'description': description,
      'professor': professor,
      'date': date,
      'price': price,
    }).then((_) {
      print('Course updated successfully');
    }).catchError((e) {
      print('Error updating course: $e');
    });
  }
}
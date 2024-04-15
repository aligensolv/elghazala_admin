import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

void main() {
  runApp(admin());
}

class Admin {
  final String name;
  final bool isConnected;

  Admin({required this.name, required this.isConnected});
}

class admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final List<Admin> admins = [
    Admin(name: 'Admin1', isConnected: true),
    Admin(name: 'Admin2', isConnected: false),
    // Add more admins as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Connected Admin:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: admins.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(admins[index].name),
                  leading: admins[index].isConnected ? Icon(Icons.check) : null,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action to modify name and password
                // Replace this with your implementation
                print('Modify Name and Password');
              },
              child: Text('Modify Name and Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action to add second admin
                // Replace this with your implementation
                print('Add Second Admin');
              },
              child: Text('Add Second Admin'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action to logout
                // Replace this with your implementation
                print('Logout');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

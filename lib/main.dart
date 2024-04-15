import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/admin.dart';
import 'package:my_app/cours.dart';
import 'package:my_app/live_now.dart';
import 'package:my_app/masters.dart';
import 'package:my_app/opinions.dart';
import 'package:my_app/statistics.dart';
import 'package:my_app/students.dart';

import 'login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBlyltqn26TTzcDKYq7mu1lArwpfx3VI2U",
        authDomain: "el-ghazala-76f03.firebaseapp.com",
        databaseURL: "https://el-ghazala-76f03-default-rtdb.firebaseio.com",
        projectId: "el-ghazala-76f03",
        storageBucket: "el-ghazala-76f03.appspot.com",
        messagingSenderId: "801596780303",
        appId: "1:801596780303:web:b85fa893e9ca18b24b187a"
      )
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DASHBOARD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildDashboardItems(context),
            SizedBox(height: 30),
            _buildSectionTitle('CONTAINS'),
            SizedBox(height: 10),
            _buildStatistics(),
            SizedBox(height: 30),
            _buildSectionTitle('LIST OF NEW OPINIONS'),
            SizedBox(height: 10),
            _buildTaskList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItems(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _buildDashboardItem(
            title: 'STUDENTS',
            icon: Icons.people,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => students()),
              );
            },
          ),
          _buildDashboardItem(
            title: 'COURS',
            icon: Icons.school,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => cours()),
              );
            },
          ),
          _buildDashboardItem(
            title: 'MASTERS',
            icon: Icons.person_2,
        onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => masters()),
              );
            },
          ),
          _buildDashboardItem(
            title: 'OPINIONS',
            icon: Icons.message,
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => opinions()),
              );
            },
          ),
          _buildDashboardItem(
            title: 'ADMIN',
            icon: Icons.admin_panel_settings,
          onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => admin()),
              );
            },
          ),
          _buildDashboardItem(
            title: 'STATISTICS',
            icon: Icons.bar_chart,
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => statistics()),
              );
            },
          ),
          _buildDashboardItem(
            title: 'LIVE NOW',
            icon: Icons.live_tv,
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => live_now()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatisticItem(label: 'Étudiants', value: '1000'),
        _buildStatisticItem(label: 'Enseignants', value: '50'),
        _buildStatisticItem(label: 'Cours', value: '20'),
      ],
    );
  }

  Widget _buildStatisticItem({required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text((index + 1).toString(), style: TextStyle(color: Colors.white)),
            ),
            title: Text('Tâche ${index + 1}'),
            subtitle: Text('Description de la tâche ${index + 1}'),
            trailing: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Action pour afficher plus de détails sur la tâche
              },
            ),
          ),
        );
      },
    );
  }
}

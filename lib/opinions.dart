import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

void main() {
  runApp(opinions());
}

class opinions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reviews',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReviewsScreen(),
    );
  }
}

class ReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
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
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviews[index].studentName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${reviews[index].email}'),
                            Row(
                              children: List.generate(reviews[index].rating, (i) {
                                return Icon(Icons.star, color: Colors.yellow);
                              }),
                            ),
                          ],
                        ),
                        Text(reviews[index].date),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(reviews[index].description),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Review {
  final String studentName;
  final String email;
  final int rating;
  final String description;
  final String date;

  Review({
    required this.studentName,
    required this.email,
    required this.rating,
    required this.description,
    required this.date,
  });
}

final List<Review> reviews = [
  Review(
    studentName: 'John Doe',
    email: 'john.doe@example.com',
    rating: 5,
    description: 'Great experience!',
    date: 'March 28, 2024',
  ),
  Review(
    studentName: 'Jane Smith',
    email: 'jane.smith@example.com',
    rating: 4,
    description: 'Enjoyed the course.',
    date: 'March 25, 2024',
  ),
  // Ajoutez plus d'avis au besoin
];

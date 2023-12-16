// ignore: file_names
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re7latekk/LogInCompany.dart';

import 'package:re7latekk/addCarr.dart';

// ignore: must_be_immutable
class CarListScreen extends StatelessWidget {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Car List',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 121, 121, 121)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,
                color: Color.fromARGB(255, 121, 121, 121)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const login_company(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cars')
            .where('addedBy', isEqualTo: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents =
                snapshot.data!.docs as List<QueryDocumentSnapshot>;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> carData =
                    documents[index].data() as Map<String, dynamic>;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    leading: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: carData['image_url'] != null
                            ? Image.file(File(carData['image_url']),
                                height: 80, width: 100, fit: BoxFit.cover)
                            : Image.asset(
                                'Images/white-offroader-jeep-parking.jpg', // Replace with the path to your default image asset
                                height: 80,
                                width: 100,
                                fit: BoxFit.cover)),
                    title: Text(
                      carData['model'],
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rental: ${carData['rental']}',
                            style: const TextStyle(color: Colors.black)),
                        Text('Passengers: ${carData['passengers']}',
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _viewCarDetails(context, carData, documents[index].id);
                      },
                      child: const Text('View'),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 130,
            // Set width to match the screen width
            child: ElevatedButton(
              onPressed: () {
                // Navigate to CarFormScreen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarForm()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF045F91), // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('ADD CAR'),
            ),
          ),
        ),
      ),
    );
  }

  // Method to navigate to a separate screen to view car details
  void _viewCarDetails(
      BuildContext context, Map<String, dynamic> carData, String docId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailsScreen(carData: carData, docId: docId),
      ),
    );
  }
}

class CarDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> carData;
  final String docId;

  const CarDetailsScreen(
      {super.key, required this.carData, required this.docId});

  Future<void> _deleteCar(BuildContext context, String carId) async {
    try {
      // Delete the car document from Firestore
      await FirebaseFirestore.instance.collection('cars').doc(carId).delete();

      // After deleting, navigate back to the CarListScreen
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the confirmation dialog
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Close the CarDetailsScreen
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CarListScreen()),
      );
    } catch (e) {
      print('Error deleting car: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 134, 240),
        title: Text(
          '${carData['model']}',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 243, 238, 238)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CarListScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (carData['image_url'] != null)
              Image.file(File(carData['image_url']),
                  height: 200, width: double.infinity, fit: BoxFit.cover),
            if (carData['image_url'] == null)
              Image.asset(
                  'Images/white-offroader-jeep-parking.jpg', // Replace with the path to your default image asset
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover),
            const SizedBox(height: 10),
            DetailsItem(
                title: "Maintenance: ", value: "${carData['maintenance']}"),
            DetailsItem(title: "Rental:      ", value: "${carData['rental']}"),
            DetailsItem(
                title: "Insurance:   ", value: "${carData['insurance']}"),
            DetailsItem(
                title: "Passengers:  ", value: "${carData['passengers']}"),

            // Add more details as needed

            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context, docId);
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text(
                  'Delete'.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String carId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Car'),
          content: const Text('Are you sure you want to delete this car?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteCar(context, carId);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DetailsItem extends StatelessWidget {
  final String title;
  final String value;
  const DetailsItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 236, 236),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

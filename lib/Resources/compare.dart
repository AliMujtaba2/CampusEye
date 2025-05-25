import 'package:flutter/material.dart';
import 'package:campuseyeapp/resources/universitydetail.dart';
import 'package:campuseyeapp/resources/compareunidata.dart';

class ComparePage extends StatefulWidget {
  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  final List<Map<String, dynamic>> universities = [
    {
      'name': 'National Textile University',
      'city': 'Lahore',
      'rank': 18,
      'logo': 'https://edurank.org/assets/img/uni-logos/university-of-the-punjab-logo.png',
      'details': 'NTU is a leading university for textile engineering in Pakistan.',
      'specializedDepartments': ['Textile Engineering', 'Fashion Design', 'Polymer Engineering']
    },
    {
      'name': 'Beaconhouse National University',
      'city': 'Lahore',
      'rank': 20,
      'logo': 'https://edurank.org/assets/img/uni-logos/university-of-the-punjab-logo.png',
      'details': 'BNU is known for its creative arts and design programs.',
      'specializedDepartments': ['Fine Arts', 'Media Studies', 'Architecture']
    },
    {
      'name': 'Shalamar Medical and Dental College',
      'city': 'Lahore',
      'rank': 25,
      'logo': 'https://edurank.org/assets/img/uni-logos/university-of-the-punjab-logo.png',
      'details': 'A premier institute for medical and dental studies.',
      'specializedDepartments': ['Medicine', 'Dentistry', 'Surgery']
    },
    {
      'name': 'University of South Asia',
      'city': 'Lahore',
      'rank': 95,
      'logo': 'https://edurank.org/assets/img/uni-logos/university-of-the-punjab-logo.png',
      'details': 'A multidisciplinary university offering various programs.',
      'specializedDepartments': ['Computer Science', 'Business', 'Law']
    },
    {
      'name': 'FAST-NUCES',
      'city': 'Lahore',
      'rank': 10,
      'logo': 'https://edurank.org/assets/img/uni-logos/university-of-the-punjab-logo.png',
      'details': 'FAST is renowned for its computer science programs.',
      'specializedDepartments': ['Computer Science', 'Electrical Engineering', 'Data Science']
    }
  ];

  List<Map<String, dynamic>> filteredUniversities = [];
  String searchQuery = '';
  List<Map<String, dynamic>> selectedUniversities = [];

  @override
  void initState() {
    super.initState();
    filteredUniversities = universities;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredUniversities = universities.where((university) {
        return university['name'].toLowerCase().contains(query.toLowerCase()) ||
            university['city'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void toggleUniversitySelection(Map<String, dynamic> university) {
    setState(() {
      if (selectedUniversities.contains(university)) {
        selectedUniversities.remove(university);
      } else if (selectedUniversities.length < 2) {
        selectedUniversities.add(university);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 2,
        title: const Text(
          'Universities',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splashscreenBackground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: updateSearchQuery,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search universities...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUniversities.length,
                itemBuilder: (context, index) {
                  final university = filteredUniversities[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UniversityDetailsPage(university: university),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: selectedUniversities.contains(university) ? Colors.yellow : Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.yellow.withOpacity(0.8), width: 1.5),
                        ),
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.network(
                              university['logo'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            university['name'],
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            university['city'],
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Checkbox(
                            value: selectedUniversities.contains(university),
                            onChanged: (value) {
                              toggleUniversitySelection(university);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: selectedUniversities.length == 2
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UniversityComparePage(
                        universities: selectedUniversities,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Compare"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

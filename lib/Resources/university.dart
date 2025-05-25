import 'package:flutter/material.dart';
import 'package:campuseyeapp/resources/universitydetail.dart';


class UniversitiesPage extends StatefulWidget {
  @override
  _UniversitiesPageState createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
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
    },
  ];

  List<Map<String, dynamic>> filteredUniversities = [];
  String searchQuery = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Universities',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: updateSearchQuery,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search by any keyword',
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.cancel, color: Colors.black54),
                    onPressed: () {
                      setState(() {
                        searchQuery = '';
                        filteredUniversities = universities;
                      });
                    },
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.yellow.withOpacity(0.6), width: 1.5),
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
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(university['city'], style: TextStyle(color: Colors.white70)),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            university['rank'].toString(),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UniversityDetailsPage(university: university),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

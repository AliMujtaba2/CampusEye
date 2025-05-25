import 'package:flutter/material.dart';

class UniversityComparePage extends StatelessWidget {
  final List<Map<String, dynamic>> universities;

  const UniversityComparePage({Key? key, required this.universities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final university1 = universities[0];
    final university2 = universities[1];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splashscreenBackground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First University Container
                      Expanded(
                        child: _buildUniversityContainer(university1),
                      ),
                      const SizedBox(width: 10),
                      // Second University Container
                      Expanded(
                        child: _buildUniversityContainer(university2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUniversityContainer(Map<String, dynamic> university) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.withOpacity(0.6), width: 1.5),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // University Logo
              ClipOval(
                child: Image.network(
                  university['logo'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // University Name
              Text(
                university['name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // City and Rank Information
              _infoRow("City", university['city']),
              _infoRow("Rank", university['rank']),
              _infoRow("Fees", university['fees']),

              const SizedBox(height: 10),

              // University Details Section
              _sectionTitle("Details"),
              Text(
                university['details'],
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),

              // Specialized Departments Section
              _sectionTitle("Departments"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  university['specializedDepartments'].length,
                      (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.yellow.withOpacity(0.6), width: 1.5),
                      ),
                      child: Text(
                        university['specializedDepartments'][index],
                        style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
          ),
          Text(
            value.toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

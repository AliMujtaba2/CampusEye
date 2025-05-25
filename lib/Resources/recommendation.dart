import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RecommendationApp(),
  ));
}

class RecommendationApp extends StatefulWidget {
  @override
  _RecommendationAppState createState() => _RecommendationAppState();
}

class _RecommendationAppState extends State<RecommendationApp> {
  String? modernFacilitiesPreference;
  String? selectedDepartment;
  String? selectedCity;
  String? selectedBudget;
  int _currentIndex = 0;

  late final List<Widget> _quizPages;

  @override
  void initState() {
    super.initState();
    _quizPages = [
      _buildMainWelcomePage(),
      _buildOptionPage(
          "Do you prefer a university with modern facilities?",
          ["Yes, very much", "Somewhat", "Not at all", "No preference"],
              (value) {
            modernFacilitiesPreference = value;
            _navigateToNextPage();
          }),
      _buildOptionPage(
          "Which department interests you?",
          ["Computer Science", "Engineering", "Business Administration", "Humanities", "Law", "Undecided"],
              (value) {
            selectedDepartment = value;
            _navigateToNextPage();
          }),
      _buildOptionPage(
          "Which city would you prefer for your university?",
          ["Lahore", "Islamabad", "Multan", "Faisalabad", "Chakwal", "Taxila", "Rawalpindi", "Gujranwala", "Karachi"],
              (value) {
            selectedCity = value;
            _navigateToNextPage();
          }),
      _buildOptionPage(
          "What is your budget?",
          ["Less than 4 lac", "Less than 8 lac", "Less than 12 lac", "Less than 25 lac", "More than 50 lac"],
              (value) {
            selectedBudget = value;
            _navigateToNextPage();
          }),
      _buildRecommendationPage(),
    ];
  }

  // Starting Page
  Widget _buildMainWelcomePage() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF1A1A1A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  label: Text("Back", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
            Icon(Icons.hexagon, color: Colors.grey.shade800, size: 60),
            SizedBox(height: 10),
            Text(
              "Recommendation",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Welcome to our University Recommendation System! We’re here to help you find the university that fits you best. Tell us what you’re looking for – whether it’s a specific city, top-ranked programs, or a vibrant campus life – and we’ll provide personalized recommendations just for you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _navigateToNextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Generalized Option Page
  Widget _buildOptionPage(String question, List<String> options, Function(String) onTap) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              question,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30),
          ...options.map((option) => _buildOptionButton(option, () {
            onTap(option);
          })),
          SizedBox(height: 50),
          _buildProgressIndicator(_currentIndex),
        ],
      ),
    );
  }

  // Recommendation Page
  Widget _buildRecommendationPage() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Recommendation Generated!",
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Reusable Option Button
  Widget _buildOptionButton(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Progress Indicator
  Widget _buildProgressIndicator(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: currentIndex == index ? Colors.yellow : Colors.grey.shade800,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  void _navigateToNextPage() {
    if (_currentIndex < _quizPages.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _quizPages[_currentIndex];
  }
}

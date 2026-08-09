import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import '../ai_assistant/key_storage.dart';
import '../pet/pet_window.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _apiKeyController = TextEditingController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    if (_apiKeyController.text.trim().isNotEmpty) {
      await SecureKeyStorage.saveApiKey(_apiKeyController.text.trim());
    }
    await SecureKeyStorage.completeOnboarding();
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PetWindow()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              _buildPage(
                title: 'Welcome to your AI Pet',
                subtitle: 'Your new intelligent companion that lives right on your desktop.',
                icon: Icons.pets,
                content: Text(
                  'Drag the pet anywhere on your screen. It will always float on top of your windows, keeping you company while you work.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
              ),
              _buildPage(
                title: 'Boost your Productivity',
                subtitle: 'Set reminders and chat effortlessly.',
                icon: Icons.bolt,
                content: Text(
                  'Press Alt+B anywhere to summon the pet instantly! You can ask it to remind you of tasks, manage birthdays, or just chat.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
              ),
              _buildPage(
                title: 'Connect the Brain',
                subtitle: 'Bring your pet to life with Gemini AI.',
                icon: Icons.memory,
                content: Column(
                  children: [
                    Text(
                      'Paste your Google Gemini API key to activate the AI features. You can do this later in settings if you prefer.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _apiKeyController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Gemini API Key',
                        hintText: 'AIzaSy...',
                        prefixIcon: Icon(Icons.key, color: AppTheme.primaryAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Navigation controls
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _finishOnboarding,
                  child: Text('Skip', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                ),
                Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? AppTheme.primaryAccent : Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(_currentPage == 2 ? 'Get Started' : 'Next'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget content,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: AppTheme.primaryAccent),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.secondaryAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          content,
        ],
      ),
    );
  }
}

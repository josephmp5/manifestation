import 'package:flutter/material.dart';
import 'package:manifestation/auth.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    void anonymousSignIn() async {
      await Auth().signInWithAnonymous(context);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onboard.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome to Manifestify 🌟',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Visualize. Believe. Achieve.",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "Manifestify is your personal guide to turning your goals into reality.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4B0082)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "🌈 Set Your Intentions: Define what you truly desire.\n✨ Daily Affirmations: Stay motivated and inspired every day.\n🌌 Manifestation Journal: Track your progress and reflect on your journey.\n🧘 Guided Practices: Meditate, visualize, and focus on your dreams.",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF800000)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 50),
                    backgroundColor: const Color(0xFF9370DB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: anonymousSignIn,
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const LoginScreen()),
              //     );
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.all(16.0),
              //     child: Center(
              //       child: Text(
              //         "Already have the subscription? Login Here",
              //         style: TextStyle(color: Colors.black, fontSize: 16),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

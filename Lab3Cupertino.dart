import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

const String studentAName = "Katrina Angel B. Farofaldane";
const String studentACourse = "BSIT - 4th Year";
const String studentAEmail = "23-69338@g.batstate-u.edu.ph";

const String studentBName = "Jeric M. Rose";
const String studentBCourse = "BSIT - 4th Year";
const String studentBEmail = "23-67574@g.batstate-u.edu.ph";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratory Act 3',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
        primaryColor: CupertinoColors.systemOrange, 
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBackground,
        border: null,
        middle: Text(
          'Laboratory Act 3: Profile',
          style: TextStyle(color: CupertinoColors.black),
        ),
      ),

      // ---------- JEK: INVISIBLE WIDGETS ----------
      child: SafeArea(
        child: Center( // centers the whole row of cards
          child: Padding( // spacing around the row
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView( // scroll
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ProfileCard(
                    name: studentAName,
                    course: studentACourse,
                    email: studentAEmail,
                    accentColor: CupertinoColors.systemOrange,
                  ),
                  SizedBox(width: 16), // margin between cards
                  ProfileCard(
                    name: studentBName,
                    course: studentBCourse,
                    email: studentBEmail,
                    accentColor: CupertinoColors.systemBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String course;
  final String email;
  final Color accentColor;

  const ProfileCard({
    super.key,
    required this.name,
    required this.course,
    required this.email,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: CupertinoColors.systemGrey5,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // ---------- KAT: VISIBLE WIDGETS ----------

          ClipOval(
            child: Container(
              width: 88,
              height: 88,
              color: CupertinoColors.systemGrey5,
              child: Image.network(
                'https://api.dicebear.com/7.x/initials/png?seed=$name&backgroundColor=transparent',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    CupertinoIcons.person_fill,
                    size: 46,
                    color: accentColor,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CupertinoActivityIndicator());
                },
              ),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.black,
            ),
          ),

          const SizedBox(height: 4), // margin before course

          Text(
            course,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: CupertinoColors.systemGrey,
            ),
          ),

          const SizedBox(height: 8), // margin before email

          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.systemGrey,
            ),
          ),

          const SizedBox(height: 14), // margin before icon

          Icon(
            CupertinoIcons.sun_max_fill,
            color: accentColor,
            size: 28,
          ),

          const SizedBox(height: 16), // margin before button

          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('Profile'),
                  content: Text('$name\'s profile viewed!'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'View Profile',
              style: TextStyle(fontSize: 14, color: accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
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
                  SizedBox(width: 16),
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

class ProfileCard extends StatefulWidget {
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
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isAvailable = true;
  int _selectedSegment = 0; // 0 = Info, 1 = Contact
  bool _isPressed = false;

  void _showProfileDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Profile'),
        content: Text('${widget.name}\'s profile viewed!'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.accentColor;

    // ---------- KAT: VISIBLE WIDGETS ----------
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => _showProfileDialog(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isPressed ? accentColor : CupertinoColors.systemGrey5,
            width: _isPressed ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // Avatar with status dot, long-press to copy email
            CupertinoContextMenu(
              actions: [
                CupertinoContextMenuAction(
                  trailingIcon: CupertinoIcons.doc_on_clipboard,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.email));
                    Navigator.pop(context);
                  },
                  child: const Text('Copy Email'),
                ),
              ],
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Container(
                      width: 88,
                      height: 88,
                      color: CupertinoColors.systemGrey5,
                      child: Image.network(
                        'https://api.dicebear.com/7.x/initials/png?seed=${widget.name}&backgroundColor=transparent',
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
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isAvailable
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemGrey,
                        border: Border.all(
                          color: CupertinoColors.systemBackground,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.black,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    _isAvailable ? 'Available' : 'Busy',
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Transform.scale(
                  scale: 0.75,
                  child: CupertinoSwitch(
                    value: _isAvailable,
                    activeTrackColor: accentColor,
                    onChanged: (val) => setState(() => _isAvailable = val),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Container(height: 1, color: CupertinoColors.systemGrey5),

            const SizedBox(height: 10),

            CupertinoSlidingSegmentedControl<int>(
              groupValue: _selectedSegment,
              backgroundColor: CupertinoColors.systemGrey6,
              thumbColor: accentColor,
              children: const <int, Widget>{
                0: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text('Info', style: TextStyle(fontSize: 12)),
                ),
                1: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text('Contact', style: TextStyle(fontSize: 12)),
                ),
              },
              onValueChanged: (int? value) {
                setState(() => _selectedSegment = value ?? 0);
              },
            ),

            const SizedBox(height: 8),

            _selectedSegment == 0
                ? CupertinoListTile(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: Icon(CupertinoIcons.book, color: accentColor, size: 18),
                    title: Text(widget.course, style: const TextStyle(fontSize: 12)),
                  )
                : CupertinoListTile(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: Icon(CupertinoIcons.mail, color: accentColor, size: 18),
                    title: Text(widget.email, style: const TextStyle(fontSize: 11)),
                  ),

            const SizedBox(height: 16),

            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              onPressed: () => _showProfileDialog(context),
              child: Text(
                'View Profile',
                style: TextStyle(fontSize: 14, color: accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

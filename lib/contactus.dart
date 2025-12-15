// lib/contactus.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController(); // ✅ NEW
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSending = false;

  // ✅ Your fixed contact details shown in the info panel
  static const String _supportEmail = 'sudeep.herin@gmail.com';
  static const String _phoneNumber = '+91 93471 37827';
  static const String _contactName = 'My Lawyer';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose(); // ✅ NEW
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // ✅ Opens dial pad with number filled
  Future<void> _callPhone() async {
    final phone = _phoneNumber.replaceAll(' ', '');
    final telUri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri, mode: LaunchMode.externalApplication);
      return;
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No dialer app found on this device/emulator.'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // ✅ Ask Yes/No and save contact as "My Lawyer"
  Future<void> _askSaveContact() async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D0F1A),
        title: Text(
          'Save contact?',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        content: Text(
          'Do you want to save $_phoneNumber as "$_contactName"?',
          style: GoogleFonts.plusJakartaSans(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'No',
              style: GoogleFonts.plusJakartaSans(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB8860B),
              foregroundColor: Colors.black87,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Yes',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );

    if (yes == true) {
      await _saveContact();
    }
  }

  Future<void> _saveContact() async {
    try {
      final allowed = await FlutterContacts.requestPermission();
      if (!allowed) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contacts permission denied.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }

      final phone = _phoneNumber.replaceAll(' ', '');

      // Avoid duplicates (simple check by name+number)
      final existing = await FlutterContacts.getContacts(withProperties: true);
      final already = existing.any((c) =>
          c.displayName.trim().toLowerCase() == _contactName.toLowerCase() &&
          c.phones.any((p) => p.number.replaceAll(' ', '') == phone));

      if (already) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contact already exists.'),
            backgroundColor: Colors.green,
          ),
        );
        return;
      }

      final contact = Contact()
        ..name.first = _contactName
        ..phones = [Phone(phone)];

      await FlutterContacts.insertContact(contact);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saved as "My Lawyer".'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint('Save contact error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save contact.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // ⭐⭐⭐ SEND MESSAGE USING WEB3FORMS ⭐⭐⭐
  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim(); // ✅ NEW
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    const String accessKey = "73239762-91f1-48fc-9353-2e84c7b151b8";
    final uri = Uri.parse("https://api.web3forms.com/submit");

    final Map<String, dynamic> body = {
      "access_key": accessKey,
      "name": name,
      "email": email,
      "replyto": email,
      "subject": subject,

      // ✅ Put phone in the message + also as an extra field
      "phone": phone,
      "message": "Phone: $phone\n\n$message",

      "from": "Mr Lawyer App",
    };

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final Map<String, dynamic> resData = jsonDecode(response.body);

      if (response.statusCode == 200 && (resData["success"] == true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully.'),
            backgroundColor: Colors.green,
          ),
        );
        _formKey.currentState?.reset();
        _phoneController.clear(); // ✅ NEW
      } else {
        debugPrint("Web3Forms Error: ${response.statusCode} — ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send message. Please try again.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      debugPrint("Web3Forms Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not send message. Check your connection.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  // ----------------------------------------------------------------------
  // UI
  // ----------------------------------------------------------------------

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: const Color(0xFF101322),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB8860B), width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Contact Us',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF090B12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 4, child: _buildInfoPanel()),
                            const SizedBox(width: 24),
                            Expanded(flex: 6, child: _buildForm()),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoPanel(),
                            const SizedBox(height: 24),
                            _buildForm(),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, color: Color(0xFFFFD47A), size: 18),
              const SizedBox(width: 6),
              Text(
                'Confidential enquiry',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'We’d love to hear from you',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Share your matter, and a member of our team will respond over email.',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF101322),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow(
                icon: Icons.email_outlined,
                title: 'Email',
                value: _supportEmail,
              ),
              const SizedBox(height: 12),

              // ✅ Phone as a button (Number + "Save contact")
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _askSaveContact,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white12),
                    backgroundColor: const Color(0xFF151523),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.phone_in_talk_outlined,
                          color: Color(0xFFB8860B), size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '$_phoneNumber  •  Save contact',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Icon(Icons.person_add_alt_1,
                          color: Colors.white70, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ✅ Call button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _callPhone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB8860B),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.call, color: Colors.black87, size: 18),
                  label: Text(
                    'Call now',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _pillChip(Icons.schedule, 'Typical response: 1–2 business days'),
                  _pillChip(Icons.lock_outline, 'End-to-end confidential'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pillChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF181B2A),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white70, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send us a message',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Full name'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 14),

          // ✅ NEW: Phone field
          TextFormField(
            controller: _phoneController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Phone number'),
            keyboardType: TextInputType.phone,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your phone';
              final digits = v.replaceAll(RegExp(r'\D'), '');
              if (digits.length < 8) return 'Please enter a valid phone number';
              return null;
            },
          ),
          const SizedBox(height: 14),

          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Email address'),
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your email';
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(v.trim())) return 'Please enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 14),

          TextFormField(
            controller: _subjectController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Subject'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter a subject' : null,
          ),
          const SizedBox(height: 14),

          TextFormField(
            controller: _messageController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('How can we help?'),
            minLines: 4,
            maxLines: 6,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter your message' : null,
          ),
          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 190,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB8860B),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
                child: _isSending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black87),
                        ),
                      )
                    : Text(
                        'Send message',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

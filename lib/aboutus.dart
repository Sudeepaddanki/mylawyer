import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static const _bg = Color(0xFF0B0B10);
  static const _card = Color(0xFF101322);
  static const _card2 = Color(0xFF0D0F1A);
  static const _accent = Color(0xFFB8860B);

  TextStyle get _titleStyle => GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w800,
        height: 1.1,
      );

  TextStyle get _subStyle => GoogleFonts.plusJakartaSans(
        color: Colors.white70,
        fontSize: 14,
        height: 1.5,
      );

  TextStyle get _chipStyle => GoogleFonts.plusJakartaSans(
        color: Colors.white70,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  TextStyle get _sectionTitle => GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w800,
      );

  TextStyle get _bodyStyle => GoogleFonts.plusJakartaSans(
        color: Colors.white70,
        fontSize: 14,
        height: 1.65,
      );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 860;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'About Us',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heroCard(context),
                const SizedBox(height: 16),

                // Stats / trust row
                isWide
                    ? Row(
                        children: [
                          Expanded(
                            child: _miniStat(
                              icon: Icons.lock_outline,
                              title: 'Confidential',
                              value: 'End-to-end',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _miniStat(
                              icon: Icons.schedule,
                              title: 'Fast updates',
                              value: 'Same day',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _miniStat(
                              icon: Icons.check_circle_outline,
                              title: 'Clear advice',
                              value: 'No jargon',
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _miniStat(
                            icon: Icons.lock_outline,
                            title: 'Confidential',
                            value: 'End-to-end',
                          ),
                          const SizedBox(height: 12),
                          _miniStat(
                            icon: Icons.schedule,
                            title: 'Fast updates',
                            value: 'Same day',
                          ),
                          const SizedBox(height: 12),
                          _miniStat(
                            icon: Icons.check_circle_outline,
                            title: 'Clear advice',
                            value: 'No jargon',
                          ),
                        ],
                      ),

                const SizedBox(height: 18),

                // Sections
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _sectionCard(
                              icon: Icons.people_alt_outlined,
                              title: 'Who we are',
                              body:
                                  'Mr Lawyer is a client-first legal team built for clarity and outcomes. We combine legal rigor with practical strategy so you always understand what happens next.',
                              bullets: const [
                                'Transparent communication',
                                'Strategy-led representation',
                                'Professional confidentiality',
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _sectionCard(
                              icon: Icons.track_changes_outlined,
                              title: 'How we work',
                              body:
                                  'Every engagement follows a predictable, disciplined workflow — so you get speed without sacrificing quality.',
                              bullets: const [
                                'Listen & map the facts',
                                'Plan the best legal route',
                                'Draft, review, and file precisely',
                                'Negotiate with purpose',
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _sectionCard(
                            icon: Icons.people_alt_outlined,
                            title: 'Who we are',
                            body:
                                'Mr Lawyer is a client-first legal team built for clarity and outcomes. We combine legal rigor with practical strategy so you always understand what happens next.',
                            bullets: const [
                              'Transparent communication',
                              'Strategy-led representation',
                              'Professional confidentiality',
                            ],
                          ),
                          const SizedBox(height: 14),
                          _sectionCard(
                            icon: Icons.track_changes_outlined,
                            title: 'How we work',
                            body:
                                'Every engagement follows a predictable, disciplined workflow — so you get speed without sacrificing quality.',
                            bullets: const [
                              'Listen & map the facts',
                              'Plan the best legal route',
                              'Draft, review, and file precisely',
                              'Negotiate with purpose',
                            ],
                          ),
                        ],
                      ),

                const SizedBox(height: 14),

                _sectionCard(
                  icon: Icons.work_outline,
                  title: 'Our focus areas',
                  body:
                      'We cover everyday legal needs and high-stakes matters with the same disciplined process.',
                  chips: const [
                    'Civil disputes',
                    'Commercial litigation',
                    'Contracts & documentation',
                    'Corporate advisory',
                    'Compliance',
                    'Employment matters',
                    'Startup support',
                    'Fundraising readiness',
                  ],
                ),

                const SizedBox(height: 14),

                _sectionCard(
                  icon: Icons.star_outline,
                  title: 'Why clients choose us',
                  body:
                      'We optimize for responsiveness, clarity, and measurable progress — not endless back-and-forth.',
                  bullets: const [
                    'Timely updates & quick turnarounds',
                    'Practical, business-savvy advice',
                    'Strict confidentiality practices',
                    'Outcome-driven execution',
                  ],
                ),

                const SizedBox(height: 14),

                _promiseCard(),

                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _heroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
        gradient: const LinearGradient(
          colors: [Color(0xFF1D1D28), Color(0xFF0B0B10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.45),
            blurRadius: 26,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, color: Color(0xFFFFD47A), size: 18),
                const SizedBox(width: 6),
                Text(
                  'Client-first legal counsel',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          Text(
            'Clarity. Strategy.\nStrong representation.',
            style: _titleStyle,
          ),
          const SizedBox(height: 10),
          Text(
            'We help you move confidently — with legal guidance that is precise, practical, and easy to understand.',
            style: _subStyle,
          ),
          const SizedBox(height: 14),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _pill(Icons.lock_outline, 'Confidential'),
              _pill(Icons.bolt, 'Fast execution'),
              _pill(Icons.description_outlined, 'Drafting & filing'),
              _pill(Icons.gavel_outlined, 'Dispute support'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: _card2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white70),
          const SizedBox(width: 6),
          Text(text, style: _chipStyle),
        ],
      ),
    );
  }

  Widget _miniStat({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF151523),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white10),
            ),
            child: Icon(icon, color: _accent, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String body,
    List<String>? bullets,
    List<String>? chips,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.35),
            blurRadius: 22,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF151523),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white10),
                ),
                child: Icon(icon, color: _accent, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: _sectionTitle),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(body, style: _bodyStyle),
          if (bullets != null && bullets.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...bullets.map((b) => _bullet(b)),
          ],
          if (chips != null && chips.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: chips.map((c) => _chip(c)).toList(),
            )
          ],
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: _accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white70,
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: _card2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _promiseCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
        gradient: LinearGradient(
          colors: [
            _card,
            _card.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            blurRadius: 26,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF151523),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white10),
            ),
            child: const Icon(Icons.shield_outlined, color: _accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Our promise', style: _sectionTitle),
                const SizedBox(height: 8),
                Text(
                  'We commit to clarity, diligence, and integrity in every engagement. '
                  'You’ll always know the status, next steps, and the reasoning behind our advice.',
                  style: _bodyStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

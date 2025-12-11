import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'contactus.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05060C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0B10),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Our Services",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeroSection(context),
          const SizedBox(height: 28),
          _buildSectionTitle("What We Do"),
          const SizedBox(height: 12),
          _buildServiceGrid(context),
          const SizedBox(height: 36),
          _buildSectionTitle("Why Clients Choose Us"),
          const SizedBox(height: 16),
          _buildBenefits(),
          const SizedBox(height: 36),
          _buildCTA(context),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // Hero Header
  // -------------------------------------------------------------
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A26), Color(0xFF0B0B10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Strategic legal solutions for ambitious individuals & businesses.",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "From corporate structuring to dispute resolution, our firm blends experience, precision, and modern legal technology to safeguard your interests.",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactUsPage()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB8860B),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Book Consultation",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // Section Title
  // -------------------------------------------------------------
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // -------------------------------------------------------------
  // GRID OF SERVICES
  // -------------------------------------------------------------
  Widget _buildServiceGrid(BuildContext context) {
    final services = [
      _ServiceItem(
        icon: Icons.balance,
        title: "Civil & Criminal Matters",
        description:
            "Representation in courts, petitions, appeals, and structured legal defence strategies.",
      ),
      _ServiceItem(
        icon: Icons.domain,
        title: "Property & Real Estate",
        description:
            "Title verification, sale agreements, property disputes, and transfer documentation.",
      ),
      _ServiceItem(
        icon: Icons.people_alt,
        title: "Family & Matrimonial",
        description:
            "Divorce, maintenance, custody matters, mediation, and settlement drafting.",
      ),
      _ServiceItem(
        icon: Icons.business_center,
        title: "Business & Contracts",
        description:
            "Drafting agreements, business setup, compliance, NDAs, vendor contracts & disputes.",
      ),
      _ServiceItem(
        icon: Icons.policy,
        title: "Regulatory Filings",
        description:
            "Professional assistance with statutory filings, notices, licensing, and registrations.",
      ),
      _ServiceItem(
        icon: Icons.support_agent,
        title: "Advisory & Legal Opinions",
        description:
            "Formal legal opinions with supporting precedents and structured recommendations.",
      ),
    ];

    return Column(
      children: services
          .map((service) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _ServiceTile(item: service),
              ))
          .toList(),
    );
  }

  // -------------------------------------------------------------
  // BENEFITS / WHY US
  // -------------------------------------------------------------
  Widget _buildBenefits() {
    final points = [
      "Clear, jargon-free explanations at every stage",
      "Transparent pricing and documented workflows",
      "Secure digital records of drafts & filings",
      "Regular case updates through structured summaries",
      "Strong negotiation & mediation experience",
    ];

    return Column(
      children: points
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: Color(0xFFB8860B), size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      p,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  // -------------------------------------------------------------
  // CTA FOOTER
  // -------------------------------------------------------------
  Widget _buildCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF0D0F1A),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text(
            "Ready to discuss your matter?",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Reach out to us for a fully confidential consultation.",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white60,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ContactUsPage()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB8860B),
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.phone, color: Colors.black87),
            label: Text(
              "Contact Now",
              style: GoogleFonts.plusJakartaSans(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================================
// DATA MODEL
// ======================================================================
class _ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  _ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ======================================================================
// SERVICE TILE UI
// ======================================================================
class _ServiceTile extends StatelessWidget {
  final _ServiceItem item;

  const _ServiceTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0F1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF151523),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, size: 26, color: const Color(0xFFB8860B)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

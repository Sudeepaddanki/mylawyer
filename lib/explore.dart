// lib/explore.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF05060C),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B0B10),
          elevation: 0,
          title: Text(
            'Explore',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          bottom: TabBar(
            indicatorColor: const Color(0xFFB8860B),
            labelStyle:
                GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: const [
              Tab(text: 'Lawyers'),
              Tab(text: 'Clients'),
              Tab(text: 'Law Students'),
            ],
          ),
        ),
        // ignore: prefer_const_constructors
        body: TabBarView(
          children: const [
            // 🔹 LAWYERS TAB
            _ExploreTabContent(
              title: 'Lawyers',
              overview:
                  'Strategic litigation units, technology-enhanced filings, and resilience planning tailored for boutique and enterprise practices.',
              imagePath: 'assets/lawyertab.png',
              sections: [
                _TabSection(
                  title: 'Litigation Pods',
                  description:
                      'Dedicated pods bring together trial counsel, researchers, and paralegals to work as a single responsive squad.',
                  icon: Icons.gavel,
                  highlights: [
                    'Playbooks for motions, discovery and appeals',
                    'Shared knowledge base with past judgments',
                    'High-touch briefs with multi-format delivery',
                  ],
                ),
                _TabSection(
                  title: 'Digital Filing & Evidence Labs',
                  description:
                      'Secure case rooms, automatic service tracking, and smart exhibits make litigation fluid from intake through verdict.',
                  icon: Icons.cloud_done,
                  highlights: [
                    'Court-ready bundles with version history',
                    'Digital evidence previews for judges and clients',
                    'Audit-friendly tracking for compliance reviews',
                  ],
                ),
                _TabSection(
                  title: 'Growth & Counsel Coaching',
                  description:
                      'Programs that help you scale new practice lines without losing boutique agility.',
                  icon: Icons.trending_up,
                  highlights: [
                    'Client development sprint guides',
                    'Pricing playbooks for retainers and alternative fees',
                    'Mentorship from senior litigators on reputation management',
                  ],
                ),
              ],
            ),

            // 🔹 CLIENTS TAB
            _ExploreTabContent(
              title: 'Clients',
              overview:
                  'Holistic partner experience that keeps founders, executives, and families informed, confident, and protected.',
              imagePath: 'assets/clientstab.png',
              sections: [
                _TabSection(
                  title: 'Intake & Strategy Sprints',
                  description:
                      'Structured workshops distill priorities, risk tolerance, and decision checkpoints within days of engagement.',
                  icon: Icons.handshake,
                  highlights: [
                    'Executive briefings and governance reports',
                    'Risk heat maps with mitigation milestones',
                    'Dedicated client concierge for requests',
                  ],
                ),
                _TabSection(
                  title: 'Transparency Dashboard',
                  description:
                      'Client portals with real-time billing snapshots, document libraries, and calendar visibility.',
                  icon: Icons.dashboard_customize,
                  highlights: [
                    'Secure messaging with encrypted archives',
                    'Outcome-focused updates after every court appearance',
                    'Narrated timelines for board and investor reviews',
                  ],
                ),
                _TabSection(
                  title: 'Resilience & Training',
                  description:
                      'Cross-functional drills that align legal strategy with operations, product, and finance.',
                  icon: Icons.shield,
                  highlights: [
                    'Scenario-based tabletop exercises',
                    'Crisis protocols for regulators and media',
                    'Custom governance templates and playbooks',
                  ],
                ),
              ],
            ),

            // 🔹 LAW STUDENTS TAB
            _ExploreTabContent(
              title: 'Law Students',
              overview:
                  'Hands-on clinical opportunities, mentorship, and skills showcases for the next generation of litigators.',
              imagePath: 'assets/lawstdtab.png',
              sections: [
                _TabSection(
                  title: 'Fellowship Rotations',
                  description:
                      'Rotations through litigation, transactions, and compliance pods with real deliverables.',
                  icon: Icons.school,
                  highlights: [
                    'Draft pleadings, memos, and closing arguments',
                    'Pairings with senior attorneys for feedback',
                    'CPT-friendly hours and evaluations',
                  ],
                ),
                _TabSection(
                  title: 'Mock Trials & Clinics',
                  description:
                      'In-house mock trials with judges, mediators, and opposing counsel for practice-ready preparation.',
                  icon: Icons.sports_mma,
                  highlights: [
                    'Live court simulations with evidence handling',
                    'Peer review and critique sessions',
                    'Recording & coaching for public speaking growth',
                  ],
                ),
                _TabSection(
                  title: 'Mentor Connect & Career Labs',
                  description:
                      'Curated mentorship and career programming linking clinics to clerkships and firm placements.',
                  icon: Icons.connect_without_contact,
                  highlights: [
                    'Resume and writing clinics with feedback',
                    'Informational interviews with alumni counsel',
                    'Access to our network of judiciary placements',
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------
// TAB CONTENT
// -----------------------------------------------------------
class _ExploreTabContent extends StatelessWidget {
  final String title;
  final String overview;
  final String imagePath; // 👈 image under title
  final List<_TabSection> sections;

  const _ExploreTabContent({
    required this.title,
    required this.overview,
    required this.sections,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),

        // 🔥 Image under title (with placeholder if not found)
        _ImageWithFallback(
          path: imagePath,
          height: 250,
          borderRadius: 18,
        ),

        const SizedBox(height: 18),
        Text(
          overview,
          style: GoogleFonts.plusJakartaSans(color: Colors.white70),
        ),
        const SizedBox(height: 20),
      ],
    );

    final sectionWidgets = sections
        .map(
          (section) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _SectionCard(section: section),
          ),
        )
        .toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        header,
        ...sectionWidgets,
        const SizedBox(height: 20),
      ],
    );
  }
}

// -----------------------------------------------------------
// IMAGE WITH FALLBACK PLACEHOLDER
// -----------------------------------------------------------
class _ImageWithFallback extends StatelessWidget {
  final String path;
  final double height;
  final double borderRadius;

  const _ImageWithFallback({
    required this.path,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        path,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          // 🔸 Placeholder if image missing
          return Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade900,
                  Colors.grey.shade800,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.image_not_supported,
                    color: Colors.white54, size: 42),
                const SizedBox(height: 6),
                Text(
                  'Image not available',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------
// SECTION CARD
// -----------------------------------------------------------
class _TabSection {
  final String title;
  final String description;
  final IconData icon;
  final List<String> highlights;

  const _TabSection({
    required this.title,
    required this.description,
    required this.icon,
    required this.highlights,
  });
}

class _SectionCard extends StatelessWidget {
  final _TabSection section;

  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1220),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(section.icon, color: const Color(0xFFB8860B)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  section.title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            section.description,
            style: GoogleFonts.plusJakartaSans(color: Colors.white70),
          ),
          const SizedBox(height: 14),
          Column(
            children: section.highlights
                .map(
                  (point) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            size: 18, color: Color(0xFFB8860B)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            point,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

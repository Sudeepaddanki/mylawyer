// lib/home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'explore.dart';
import 'aboutus.dart';
import 'contactus.dart'; // 🔹 Contact page import
import 'services.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MrLawyerApp());
}

class MrLawyerApp extends StatelessWidget {
  const MrLawyerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Lawyer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          background: Color(0xFF0B0B10),
          primary: Color(0xFFB8860B),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        homeRouteName: (_) => const HomePage(),
      },
    );
  }
}

/// Dark-premium animated landing page: Hero, Services, Founders, About, Footer.
/// Uses placeholders if image assets are missing.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openExplore() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ExplorePage()),
    );
  }

  void _openContact() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ContactUsPage()),
    );
  }

  void _openServices() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ServicesPage()),
    );
  }

  void _openAbout() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B10),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFB8860B), Color(0xFFFFD47A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.balance, color: Colors.black87, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'My Lawyer',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      drawer: _MainDrawer(
        onExplore: _openExplore,
        onServices: _openServices,
        onAbout: _openAbout,
        onContact: _openContact, // 🔹 Contact from drawer
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // HERO
          SliverToBoxAdapter(
            child: _FadeInOnScroll(
              id: 'hero',
              child: _Hero(
                onExplore: _openExplore,
                onConsult: _openContact, // 🔹 "Consult a Lawyer"
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 36)),

          // FOUNDERS
          SliverToBoxAdapter(
            child: _FadeInOnScroll(
              id: 'founders',
              child: const _FoundersSection(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 36)),

          // STATS
          SliverToBoxAdapter(
            child: _FadeInOnScroll(
              id: 'stats',
              child: _StatsRibbon(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 36)),

          // SERVICES
          SliverToBoxAdapter(
            child: _FadeInOnScroll(
              id: 'services',
              child: const _ServicesSection(),
            ),
          ),

          // SVG-friendly Image–Text–Image section just below Services
          SliverToBoxAdapter(
            child: _FadeInOnScroll(
              id: 'image-text-image',
              child: _ImageTextImageSection(
                topImagePath: 'assets/people.svg',
                bottomImagePath: 'assets/lawyers.svg',
                title: 'Legal strategy that scales with you.',
                body:
                    'From first notice to final order, we help founders and businesses build repeatable legal workflows, '
                    'documentation, and governance that keep pace with growth.',
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 36)),

          // APPROACH
          SliverToBoxAdapter(
            child: _FadeInOnScroll(
              id: 'approach',
              child: _ApproachSection(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 36)),

          // FOOTER
          SliverToBoxAdapter(
            child: _FadeInOnScroll(
              id: 'footer',
              child: _FooterSection(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }
}

/// Wrapper that fades its child in **when it scrolls into view**
class _FadeInOnScroll extends StatefulWidget {
  final String id;
  final Widget child;
  final Duration duration;

  const _FadeInOnScroll({
    required this.id,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<_FadeInOnScroll> createState() => _FadeInOnScrollState();
}

class _FadeInOnScrollState extends State<_FadeInOnScroll> {
  bool _hasFadedIn = false;

  void _handleVisibility(VisibilityInfo info) {
    if (!_hasFadedIn && info.visibleFraction > 0.15) {
      setState(() => _hasFadedIn = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.id),
      onVisibilityChanged: _handleVisibility,
      child: AnimatedOpacity(
        opacity: _hasFadedIn ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _hasFadedIn ? Offset.zero : const Offset(0, 0.06),
          duration: widget.duration,
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Safe image widget with placeholder when asset is missing (for raster images).
class _SafeImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  const _SafeImage({
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF151520),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white10),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: Colors.white24,
            size: 32,
          ),
        );
      },
    );
  }
}

/// HERO
class _Hero extends StatelessWidget {
  final VoidCallback onExplore;
  final VoidCallback onConsult;

  const _Hero({
    required this.onExplore,
    required this.onConsult,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return Stack(
      children: [
        // 🔥 Background with top/bottom fade
        SizedBox(
          height: isWide ? 640 : 520,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const _SafeImage(
                path: 'assets/service3.png',
                fit: BoxFit.cover,
              ),
              // Dark overlay
              Container(
                color: Colors.black.withOpacity(0.35),
              ),
              // 🔥 TOP FADE
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 140,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF0B0B10),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // 🔥 BOTTOM FADE
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 180,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFF0B0B10),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Decorative glow
        Positioned(
          right: -80,
          top: 40,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Colors.amber.withOpacity(0.12),
                ],
              ),
            ),
          ),
        ),

        // Main Content
        Positioned.fill(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // LEFT SIDE TEXT
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.verified,
                                    color: Colors.amber, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Trusted legal counsel',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 600.ms),
                          const SizedBox(height: 20),

                          // Heading
                          Text(
                            'Strategic defense. Bold outcomes.',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: isWide ? 46 : 32,
                            ),
                          )
                              .animate()
                              .slide(begin: const Offset(-0.15, 0))
                              .fadeIn(delay: 120.ms, duration: 600.ms),

                          const SizedBox(height: 12),

                          // Subheading
                          SizedBox(
                            width: isWide ? 560 : double.infinity,
                            child: Text(
                              'We combine courtroom experience with modern litigation operations — faster case prep, sharp strategy, and discreet client service.',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ).animate().fadeIn(delay: 240.ms),
                          ),

                          const SizedBox(height: 24),

                          // Buttons
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: onExplore,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB8860B),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.explore_outlined,
                                        color: Colors.black87),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Explore',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  .animate()
                                  .scale(delay: 320.ms)
                                  .then()
                                  .shake(duration: 600.ms, hz: 2),

                              const SizedBox(width: 12),

                              OutlinedButton(
                                onPressed: onConsult,
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.white.withOpacity(0.14)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 14),
                                  foregroundColor: Colors.white70,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.phone_in_talk,
                                        color: Colors.white70),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Consult a Lawyer',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(delay: 380.ms),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 18),

                    // RIGHT SIDE IMAGE (desktop only)
                    if (isWide)
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 360,
                            width: 360,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.45),
                                  blurRadius: 40,
                                  offset: const Offset(0, 18),
                                ),
                              ],
                              color: const Color(0xFF101320),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: const _SafeImage(
                                path: 'assets/images/hero-card.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(duration: 700.ms)
                              .slide(begin: const Offset(0.15, 0)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// STATS RIBBON
class _StatsRibbon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      ('98%', 'Success rate'),
      ('24+', 'Specialist attorneys'),
      ('320+', 'Enterprise clients'),
      ('50 yrs', 'Combined experience'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1220),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 28,
              runSpacing: 12,
              children: stats
                  .map(
                    (s) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          s.$1,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          s.$2,
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.white70),
                        ),
                      ],
                    ).animate().fadeIn(),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// SERVICES SECTION
class _ServicesSection extends StatelessWidget {
  const _ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      (
        'assets/service1.png',
        'High-stakes Litigation',
        'Boardroom disputes, regulatory responses, and cross-border claims.'
      ),
      (
        'assets/service2.png',
        'Transactions & Capital',
        'M&A, financing, and contract strategy for high-value deals.'
      ),
      (
        'assets/service3.png',
        'Risk & Compliance Labs',
        'Automation, reporting, and bespoke compliance playbooks.'
      ),
      (
        'assets/service4.png',
        'Private Client Advisory',
        'Concierge legal support for founders and family offices.'
      ),
    ];
    final isWide = MediaQuery.of(context).size.width > 900;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What we do',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'End-to-end legal services designed for modern enterprises.',
                style: GoogleFonts.plusJakartaSans(color: Colors.white70),
              ),
              const SizedBox(height: 18),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 2 : 1,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  mainAxisExtent: 160,
                ),
                itemBuilder: (context, index) {
                  final s = services[index];
                  return _ServiceCard(
                    imagePath: s.$1,
                    title: s.$2,
                    summary: s.$3,
                    delay: index * 120,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String summary;
  final int delay;

  const _ServiceCard({
    required this.imagePath,
    required this.title,
    required this.summary,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    // detect if this card is even or odd in GridView order
    final index = (delay ~/ 120);
    final isEven = index % 2 == 0;

    final leftImageLayout = Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _SafeImage(
            path: imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: _serviceTextBlock()),
      ],
    );

    final rightImageLayout = Row(
      children: [
        Expanded(child: _serviceTextBlock()),
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _SafeImage(
            path: imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );

    return Material(
      color: const Color(0xFF0F1220),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: isEven ? leftImageLayout : rightImageLayout,
        ),
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: delay),
          duration: 500.ms,
        );
  }

  Widget _serviceTextBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          summary,
          style: GoogleFonts.plusJakartaSans(color: Colors.white70),
        ),
        const Spacer(),
      ],
    );
  }
}

/// IMAGE - TEXT - IMAGE SECTION (supports .svg and raster)
class _ImageTextImageSection extends StatelessWidget {
  final String topImagePath;
  final String bottomImagePath;
  final String title;
  final String body;

  const _ImageTextImageSection({
    super.key,
    required this.topImagePath,
    required this.bottomImagePath,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
            decoration: BoxDecoration(
              color: const Color(0xFF090B12).withOpacity(0.9),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: _buildAsset(topImagePath),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: _buildAsset(bottomImagePath),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAsset(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        fit: BoxFit.contain,
      );
    }
    return _SafeImage(
      path: path,
      fit: BoxFit.contain,
    );
  }
}

/// APPROACH SECTION (small)
class _ApproachSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Discovery', 'Immersive workshops to calibrate risk and priorities.'),
      ('Blueprint', 'Scenario modelling and decision playbooks.'),
      ('Execution', 'Dedicated pods deliver pleadings and filings.'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1220),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: steps
                  .map(
                    (s) => Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.$1,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text(s.$2,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white70)),
                        ],
                      ),
                    ).animate().fadeIn(),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// FOUNDERS SECTION
class _FoundersSection extends StatelessWidget {
  const _FoundersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final founders = [
      ('assets/founder.png', 'Sujith Addanki', 'Founder'),
      ('assets/cofounder.png', 'Rajesh Addanki', 'Co-Founder'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Founders',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: founders
                    .map(
                      (f) => Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF0F1220),
                              ),
                              child: ClipOval(
                                child: _SafeImage(
                                  path: f.$1,
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              f.$2,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              f.$3,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 600.ms),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// FOOTER
class _FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF060609),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LOGO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFB8860B), Color(0xFFFFD47A)],
                      ),
                    ),
                    child: const Icon(Icons.balance,
                        color: Colors.black87, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Lawyer',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Premium litigation & advisory',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30),

              // CONTACT ICONS + INFO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gmail contact
                  Column(
                    children: [
                      const Icon(Icons.alternate_email,
                          color: Colors.white70, size: 26),
                      const SizedBox(height: 8),
                      Text(
                        "Contact us",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "hello@example.com",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 60),

                  // Phone contact
                  Column(
                    children: [
                      const Icon(Icons.phone, color: Colors.white70, size: 26),
                      const SizedBox(height: 8),
                      Text(
                        "Phone",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "+91 98765 43210",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Divider(color: Colors.white12),
              const SizedBox(height: 28),

              // FOLLOW US SECTION
              Text(
                "Follow us",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt,
                      color: Colors.white70, size: 26), // Insta placeholder
                  SizedBox(width: 22),
                  Icon(Icons.facebook, color: Colors.white70, size: 26),
                  SizedBox(width: 22),
                  Icon(Icons.share,
                      color: Colors.white70, size: 26), // Twitter placeholder
                ],
              ),

              const SizedBox(height: 32),

              // COPYRIGHT TRADEMARK
              Text(
                "© ${2025} My Lawyer — All rights reserved",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainDrawer extends StatelessWidget {
  final VoidCallback onExplore;
  final VoidCallback onServices;
  final VoidCallback onAbout;
  final VoidCallback onContact; // 🔹 new

  const _MainDrawer({
    required this.onExplore,
    required this.onServices,
    required this.onAbout,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF07070F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB8860B), Color(0xFF5C3B0C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.balance, color: Colors.black87, size: 28),
                const SizedBox(height: 8),
                Text(
                  'My Lawyer',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Strategy, litigation, trust',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _DrawerTile(
            icon: Icons.explore,
            title: 'Explore',
            onTap: () {
              Navigator.pop(context);
              onExplore();
            },
          ),
          _DrawerTile(
            icon: Icons.auto_awesome_motion,
            title: 'Services',
            onTap: () {
              Navigator.pop(context);
              onServices();
            },
          ),
          _DrawerTile(
            icon: Icons.info_outline,
            title: 'About Us',
            onTap: () {
              Navigator.pop(context);
              onAbout();
            },
          ),
          const Divider(color: Colors.white12),
          _DrawerTile(
            icon: Icons.phone,
            title: 'Contact',
            onTap: () {
              Navigator.pop(context);
              onContact(); // 🔹 open ContactUsPage
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Stay connected: hello@example.com',
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
            color: Colors.white70, fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
    );
  }
}




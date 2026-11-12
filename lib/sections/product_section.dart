import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/app_mockups.dart';
import '../widgets/common.dart';
import '../widgets/store_links.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
    required this.onStartProject,
    required this.onExploreProcess,
  });

  final VoidCallback onStartProject;
  final VoidCallback onExploreProcess;

  @override
  Widget build(BuildContext context) {
    return SiteBody(
      padding: const EdgeInsets.symmetric(vertical: 112),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: Row(
              children: [
                const SectionEyebrow('02', 'Flagship product'),
                const Spacer(),
                if (MediaQuery.sizeOf(context).width >= 720)
                  Text(
                    'PRODUCT 01 / BUILT IN-HOUSE',
                    style: T.mono(8.5, color: Brand.dim, letterSpacing: 1.6),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 34),
          LayoutBuilder(
            builder: (context, constraints) {
              final desktop = constraints.maxWidth >= 940;
              final copy = _OjraCopy(
                onStartProject: onStartProject,
                onExploreProcess: onExploreProcess,
                compact: !desktop,
              );
              final stage = _OjraStage(
                wide: desktop,
                height: desktop ? 640 : 500,
              );
              if (desktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: copy),
                    const SizedBox(width: 48),
                    Expanded(flex: 6, child: stage),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [copy, const SizedBox(height: 42), stage],
              );
            },
          ),
          const SizedBox(height: 28),
          const _OjraProofStrip(),
        ],
      ),
    );
  }
}

class _OjraCopy extends StatelessWidget {
  const _OjraCopy({
    required this.onStartProject,
    required this.onExploreProcess,
    required this.compact,
  });

  final VoidCallback onStartProject;
  final VoidCallback onExploreProcess;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final titleSize = compact ? (width < 420 ? 40.0 : 45.0) : 52.0;
    const features = <(IconData, String)>[
      (Icons.my_location_rounded, 'Live GPS & real-time tracking'),
      (Icons.radar_rounded, 'Nearest-driver dispatch'),
      (Icons.payments_outlined, 'Upfront fare estimates'),
      (Icons.local_taxi_outlined, 'Economy, XL & premium'),
      (Icons.star_outline_rounded, 'Ratings & trip history'),
      (Icons.account_balance_wallet_outlined, 'Driver earnings & low fees'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: Brand.ojraGradient,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      color: Brand.ojra.withValues(alpha: 0.3),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/ojra_wordmark.png',
                  fit: BoxFit.contain,
                  semanticLabel: 'Ojra',
                ),
              ),
              const SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OJRA',
                    style: T.display(
                      21,
                      weight: FontWeight.w600,
                      letterSpacing: 2.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'RIDER + DRIVER PLATFORM',
                    style: T.mono(7.8, color: Brand.dim, letterSpacing: 1.6),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('One platform.', style: T.display(titleSize, height: 1.03)),
              Text('Two apps.', style: T.display(titleSize, height: 1.03)),
              GradientText(
                'Every ride in sync.',
                style: T.display(titleSize, height: 1.03),
                gradient: Brand.ojraGradient,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Reveal(
          delay: const Duration(milliseconds: 120),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 490),
            child: Text(
              'Ojra is a complete ride-hailing system: a rider app and a driver app running on one real-time backbone. Live maps, nearest-driver dispatch, upfront fares, ratings and driver earnings — designed, engineered and shipped to Google Play by New Age Factories.',
              style: T.body(15, color: Brand.muted, height: 1.7),
            ),
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final twoColumn = constraints.maxWidth >= 380;
              final itemWidth = twoColumn
                  ? (constraints.maxWidth - 12) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: 12,
                runSpacing: 13,
                children: [
                  for (final feature in features)
                    SizedBox(
                      width: itemWidth,
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Brand.ojra.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Brand.ojra.withValues(alpha: 0.18),
                              ),
                            ),
                            child: Icon(
                              feature.$1,
                              size: 12,
                              color: const Color(0xFFFF8EB3),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              feature.$2,
                              style: T.body(
                                12.2,
                                weight: FontWeight.w500,
                                color: const Color(0xFFC6D0E0),
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 240),
          child: Wrap(
            spacing: 7,
            runSpacing: 7,
            children: const [
              TagChip('Flutter', dotColor: Brand.ojra),
              TagChip('Firebase'),
              TagChip('Google Maps'),
              TagChip('iOS + Android'),
            ],
          ),
        ),
        const SizedBox(height: 26),
        Reveal(
          delay: const Duration(milliseconds: 270),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Brand.lime,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'LIVE ON GOOGLE PLAY',
                    style: T.mono(7.5, color: Brand.dim, letterSpacing: 1.5),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const OjraStoreLinks(),
            ],
          ),
        ),
        const SizedBox(height: 26),
        Reveal(
          delay: const Duration(milliseconds: 330),
          child: Wrap(
            spacing: 10,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              NafButton(
                label: 'Build a platform like Ojra',
                onPressed: onStartProject,
              ),
              ArrowLink(label: 'See how we build', onPressed: onExploreProcess),
            ],
          ),
        ),
      ],
    );
  }
}

class _OjraStage extends StatelessWidget {
  const _OjraStage({required this.wide, required this.height});

  final bool wide;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 70,
            spreadRadius: -20,
            offset: const Offset(0, 30),
          ),
          BoxShadow(
            color: Brand.ojra.withValues(alpha: 0.08),
            blurRadius: 80,
            spreadRadius: -10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/ojra_stage.jpg',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
              semanticLabel: 'City skyline at dusk',
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xA605070E),
                    Color(0x99070A12),
                    Color(0xED05070E),
                  ],
                  stops: [0, 0.5, 1],
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.3, 0.2),
                  radius: 0.9,
                  colors: [
                    Brand.ojra.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: const _OjraLinesPainter()),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  GlassPill(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Brand.lime,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Brand.lime.withValues(alpha: 0.8),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'LIVE PLATFORM',
                          style: T.mono(
                            7.6,
                            color: const Color(0xFFD7E1F0),
                            letterSpacing: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xA6080B13),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      wide ? 'LIVE ON GOOGLE PLAY' : 'RIDER + DRIVER',
                      style: T.mono(
                        7.2,
                        color: Brand.muted,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: -20,
              bottom: 30,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.07,
                  child: Image.asset(
                    'assets/images/ojra_wordmark.png',
                    width: 320,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 54,
              bottom: 22,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final phoneWidth = math
                      .min(
                        math.min(
                          wide ? 238.0 : 210.0,
                          (constraints.maxWidth - 48) / 2,
                        ),
                        math.max(
                          110.0,
                          (constraints.maxHeight - 42) * 250 / 520,
                        ),
                      )
                      .toDouble();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Transform.rotate(
                            angle: -0.035,
                            child: _LabelledPhone(
                              label: 'RIDER',
                              color: Brand.cyan,
                              width: phoneWidth,
                              child: RiderPhonePreview(width: phoneWidth),
                            ),
                          ),
                          SizedBox(width: wide ? 14 : 6),
                          Transform.rotate(
                            angle: 0.035,
                            child: _LabelledPhone(
                              label: 'DRIVER',
                              color: Brand.ojra,
                              width: phoneWidth,
                              child: DriverPhonePreview(width: phoneWidth),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              left: 20,
              bottom: 18,
              child: Row(
                children: [
                  Container(width: 22, height: 1, color: Brand.ojra),
                  const SizedBox(width: 8),
                  Text(
                    'ONE BACKEND / ZERO FRICTION',
                    style: T.mono(6.8, color: Brand.muted, letterSpacing: 1.2),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 18,
              child: Text(
                '© OJRA',
                style: T.mono(6.8, color: Brand.dim, letterSpacing: 1.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabelledPhone extends StatelessWidget {
  const _LabelledPhone({
    required this.label,
    required this.color,
    required this.width,
    required this.child,
  });

  final String label;
  final Color color;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xB3080B13),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: color.withValues(alpha: 0.28)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                '$label APP',
                style: T.mono(6.6, color: Brand.ink, letterSpacing: 1.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OjraProofStrip extends StatelessWidget {
  const _OjraProofStrip();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        const items = <(String, String, IconData)>[
          (
            'Two roles, one system',
            'Dedicated rider and driver apps moving on the same real-time data.',
            Icons.devices_rounded,
          ),
          (
            'Realtime by design',
            'Live location, dispatch and trip status — updated in the moment.',
            Icons.bolt_rounded,
          ),
          (
            'Live on Google Play',
            'Ojra Rider and Ojra Driver are published, maintained and shipping updates.',
            Icons.android_rounded,
          ),
        ];
        final cards = items
            .map(
              (item) => _ProofCard(
                title: item.$1,
                description: item.$2,
                icon: item.$3,
              ),
            )
            .toList();
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < cards.length; i++) ...[
                Expanded(child: cards[i]),
                if (i < cards.length - 1) const SizedBox(width: 14),
              ],
            ],
          );
        }
        return Column(
          children: [
            for (var i = 0; i < cards.length; i++) ...[
              cards[i],
              if (i < cards.length - 1) const SizedBox(height: 10),
            ],
          ],
        );
      },
    );
  }
}

class _ProofCard extends StatelessWidget {
  const _ProofCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.018),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Brand.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Brand.ojra.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: Brand.ojra.withValues(alpha: 0.16)),
            ),
            child: Icon(icon, size: 15, color: const Color(0xFFFF8EB3)),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: T.body(
                    12.5,
                    weight: FontWeight.w600,
                    color: Brand.ink,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: T.body(11.8, color: Brand.muted, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OjraLinesPainter extends CustomPainter {
  const _OjraLinesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Brand.ojra.withValues(alpha: 0),
          Brand.ojra.withValues(alpha: 0.4),
          Brand.cyan.withValues(alpha: 0.2),
          Brand.cyan.withValues(alpha: 0),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path()
      ..moveTo(-20, size.height * 0.7)
      ..cubicTo(
        size.width * 0.22,
        size.height * 0.52,
        size.width * 0.34,
        size.height * 0.78,
        size.width * 0.54,
        size.height * 0.58,
      )
      ..cubicTo(
        size.width * 0.72,
        size.height * 0.4,
        size.width * 0.82,
        size.height * 0.5,
        size.width + 20,
        size.height * 0.26,
      );
    canvas.drawPath(path, paint);

    for (var i = 0; i < 3; i++) {
      final x = size.width * (0.12 + i * 0.28);
      final y = size.height * (0.63 - i * 0.1);
      canvas.drawCircle(
        Offset(x, y),
        2,
        Paint()..color = Brand.ojra.withValues(alpha: 0.5),
      );
      canvas.drawCircle(
        Offset(x, y),
        8,
        Paint()..color = Brand.ojra.withValues(alpha: 0.08),
      );
    }

    // Fine technical lines at the right edge.
    for (var i = 0; i < 5; i++) {
      final y = size.height * (0.14 + i * 0.035);
      canvas.drawLine(
        Offset(size.width - 70, y),
        Offset(size.width - 16, y),
        Paint()..color = Colors.white.withValues(alpha: 0.035),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OjraLinesPainter oldDelegate) => false;
}

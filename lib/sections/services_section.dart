import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key, required this.onStartProject});

  final VoidCallback onStartProject;

  @override
  Widget build(BuildContext context) {
    return SiteBody(
      padding: const EdgeInsets.symmetric(vertical: 112),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(child: _ServicesHeader()),
          const SizedBox(height: 56),
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final desktop = w >= 1000;
              final tablet = w >= 720;
              final mobile = !tablet;
              const gap = 18.0;

              final cardOne = _ServiceCard(
                number: '01',
                icon: Icons.phone_iphone_rounded,
                accent: Brand.cyan,
                title: 'Mobile apps',
                description:
                    'Native-feeling apps for iOS and Android from one Flutter codebase — built for speed, offline realities and real users.',
                tags: const ['Flutter', 'iOS', 'Android'],
                height: desktop ? 400 : (mobile ? 430 : 390),
                visual: const _MiniPhoneVisual(),
              );
              final cardTwo = _ServiceCard(
                number: '02',
                icon: Icons.hub_outlined,
                accent: Brand.violet,
                title: 'Digital solutions',
                description:
                    'Custom platforms and integrations that connect the tools, teams and data your business already runs on.',
                tags: const ['APIs', 'Automation', 'Cloud'],
                height: desktop ? 400 : (mobile ? 390 : 390),
                visual: const _TerminalVisual(),
              );
              final cardThree = _ServiceCard(
                number: '03',
                icon: Icons.language_rounded,
                accent: Brand.blue,
                title: 'Websites',
                description:
                    'Fast, expressive websites and web apps that look sharp, load quickly and convert.',
                tags: const ['Flutter web', 'SEO', 'CMS'],
                height: desktop ? 352 : (mobile ? 360 : 340),
                visual: const _BrowserVisual(),
              );
              final cardFour = _ServiceCard(
                number: '04',
                icon: Icons.shopping_bag_outlined,
                accent: Brand.magenta,
                title: 'E-commerce',
                description:
                    'Storefronts, payments and fulfilment flows that turn browsing into repeat business.',
                tags: const ['Storefronts', 'Payments', 'Logistics'],
                height: desktop ? 352 : (mobile ? 360 : 340),
                image: 'assets/images/commerce_stage.jpg',
                visual: const _CommerceVisual(),
              );
              final cardFive = _ServiceCard(
                number: '05',
                icon: Icons.settings_ethernet_rounded,
                accent: Brand.lime,
                title: 'Networking',
                description:
                    'Reliable network design and secure infrastructure — the invisible layer that keeps everything online.',
                tags: const ['Infrastructure', 'Security', 'Support'],
                height: desktop ? 352 : (mobile ? 350 : 310),
                image: 'assets/images/network_stage.jpg',
                visual: const _NetworkVisual(),
              );

              if (desktop) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 7, child: cardOne),
                        const SizedBox(width: gap),
                        Expanded(flex: 5, child: cardTwo),
                      ],
                    ),
                    const SizedBox(height: gap),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: cardThree),
                        const SizedBox(width: gap),
                        Expanded(child: cardFour),
                        const SizedBox(width: gap),
                        Expanded(child: cardFive),
                      ],
                    ),
                  ],
                );
              }

              if (tablet) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: cardOne),
                        const SizedBox(width: gap),
                        Expanded(child: cardTwo),
                      ],
                    ),
                    const SizedBox(height: gap),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: cardThree),
                        const SizedBox(width: gap),
                        Expanded(child: cardFour),
                      ],
                    ),
                    const SizedBox(height: gap),
                    cardFive,
                  ],
                );
              }

              return Column(
                children: [
                  cardOne,
                  const SizedBox(height: gap),
                  cardTwo,
                  const SizedBox(height: gap),
                  cardThree,
                  const SizedBox(height: gap),
                  cardFour,
                  const SizedBox(height: gap),
                  cardFive,
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          Reveal(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.018),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Brand.line),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 620;
                  final message = Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.auto_awesome_outlined,
                          size: 16,
                          color: Brand.cyan,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Need something that doesn’t fit a category? That’s usually where we do our best work.',
                          style: T.body(13, color: Brand.muted),
                        ),
                      ),
                    ],
                  );
                  if (compact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        message,
                        const SizedBox(height: 14),
                        ArrowLink(
                          label: 'Tell us about it',
                          onPressed: onStartProject,
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: message),
                      const SizedBox(width: 24),
                      ArrowLink(
                        label: 'Tell us about it',
                        onPressed: onStartProject,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesHeader extends StatelessWidget {
  const _ServicesHeader();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width >= 900;
    final titleSize = desktop ? 55.0 : (width < 420 ? 38.0 : 43.0);

    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full-stack craft for', style: T.display(titleSize, height: 1.05)),
        GradientText(
          'the digital age.',
          style: T.display(titleSize, height: 1.05),
        ),
      ],
    );

    final description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 42, height: 1, color: Brand.lineStrong),
        const SizedBox(height: 18),
        Text(
          'Strategy, design and engineering under one roof — so your product ships faster, feels coherent and holds up in the real world.',
          style: T.body(15, color: Brand.muted, height: 1.7),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            TagChip('Strategy'),
            TagChip('Design'),
            TagChip('Engineering'),
          ],
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SectionEyebrow('01', 'Capabilities'),
            const Spacer(),
            if (desktop)
              Text(
                'FIVE DISCIPLINES / ONE TEAM',
                style: T.mono(8.5, color: Brand.dim, letterSpacing: 1.6),
              ),
          ],
        ),
        const SizedBox(height: 34),
        if (desktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(flex: 6, child: title),
              const SizedBox(width: 60),
              Expanded(flex: 4, child: description),
            ],
          )
        else ...[
          title,
          const SizedBox(height: 26),
          description,
        ],
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.number,
    required this.icon,
    required this.accent,
    required this.title,
    required this.description,
    required this.tags,
    required this.height,
    this.visual,
    this.image,
  });

  final String number;
  final IconData icon;
  final Color accent;
  final String title;
  final String description;
  final List<String> tags;
  final double height;
  final Widget? visual;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          height: height,
          transform: Matrix4.translationValues(0, hovered ? -5 : 0, 0),
          decoration: BoxDecoration(
            gradient: Brand.surfaceGradient,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: hovered
                  ? accent.withValues(alpha: 0.34)
                  : Colors.white.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: hovered ? 0.45 : 0.22),
                blurRadius: hovered ? 40 : 24,
                spreadRadius: -8,
                offset: const Offset(0, 18),
              ),
              if (hovered)
                BoxShadow(
                  color: accent.withValues(alpha: 0.08),
                  blurRadius: 50,
                  spreadRadius: -10,
                ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (image != null)
                Positioned.fill(
                  child: Image.asset(
                    image!,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              if (image != null)
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x6605070E), Color(0xF205070E)],
                        stops: [0, 0.82],
                      ),
                    ),
                  ),
                ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.8, -0.8),
                      radius: 1.2,
                      colors: [
                        accent.withValues(alpha: image == null ? 0.14 : 0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              if (visual != null) Positioned.fill(child: visual!),
              if (image == null)
                Positioned.fill(
                  child: CustomPaint(painter: _DotFieldPainter(color: accent)),
                ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Brand.bg.withValues(alpha: 0.82),
                      ],
                      stops: const [0.35, 1],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          number,
                          style: T.mono(9.5, color: accent, letterSpacing: 1.5),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 18,
                          height: 1,
                          color: Brand.lineStrong,
                        ),
                        const Spacer(),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.18),
                            border: Border.all(
                              color: hovered
                                  ? accent.withValues(alpha: 0.4)
                                  : Brand.line,
                            ),
                          ),
                          child: Icon(icon, size: 15, color: accent),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: T.display(
                        27,
                        weight: FontWeight.w600,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: Text(
                        description,
                        style: T.body(
                          13,
                          color: const Color(0xFFA4B0C4),
                          height: 1.55,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [for (final tag in tags) TagChip(tag)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DotFieldPainter extends CustomPainter {
  _DotFieldPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.055);
    const gap = 22.0;
    for (double x = 0; x < size.width; x += gap) {
      for (double y = 0; y < size.height; y += gap) {
        final fade = 1 - (y / size.height).clamp(0.0, 1.0);
        paint.color = color.withValues(alpha: 0.16 * fade);
        canvas.drawCircle(Offset(x, y), 0.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotFieldPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _MiniPhoneVisual extends StatelessWidget {
  const _MiniPhoneVisual();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 430;
        final phoneWidth = compact ? 102.0 : 122.0;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 52,
              right: compact ? 48 : 74,
              child: Transform.rotate(
                angle: -0.16,
                child: Opacity(
                  opacity: 0.55,
                  child: _MiniPhone(width: phoneWidth, variant: 2),
                ),
              ),
            ),
            Positioned(
              top: 26,
              right: compact ? 14 : 30,
              child: Transform.rotate(
                angle: 0.09,
                child: _MiniPhone(width: phoneWidth, variant: 1),
              ),
            ),
            Positioned(
              top: 32,
              right: (compact ? 14 : 30) + phoneWidth - 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xEE0B1019),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Brand.cyan.withValues(alpha: 0.25)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Brand.lime,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'LIVE',
                      style: T.mono(6.4, color: Brand.lime, letterSpacing: 0.8),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MiniPhone extends StatelessWidget {
  const _MiniPhone({required this.width, required this.variant});

  final double width;
  final int variant;

  @override
  Widget build(BuildContext context) {
    final height = width * 2.02;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: variant == 1
              ? const [Color(0x995A8BFF), Color(0x22FFFFFF), Color(0x668B6CFF)]
              : const [Color(0x447A8BA5), Color(0x0FFFFFFF)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF090D16),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              top: 9,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: width * 0.3,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.08, 24, width * 0.08, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: Brand.signature,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: width * 0.22,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.10),
                  Text(
                    variant == 1 ? '04' : '12',
                    style: T.display(
                      width * 0.23,
                      weight: FontWeight.w600,
                      color: Brand.ink,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: width * 0.025),
                  Container(
                    width: width * 0.36,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: width * 0.08),
                  Container(
                    height: width * 0.30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          Brand.cyan.withValues(alpha: 0.16),
                          Brand.violet.withValues(alpha: 0.12),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                    child: CustomPaint(
                      painter: _MiniChartPainter(
                        color: variant == 1 ? Brand.cyan : Brand.violet,
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.07),
                  for (var i = 0; i < 3; i++) ...[
                    Row(
                      children: [
                        Container(
                          width: width * 0.09,
                          height: width * 0.09,
                          decoration: BoxDecoration(
                            color: [
                              Brand.cyan,
                              Brand.violet,
                              Brand.magenta,
                            ][i].withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 2.5,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.19),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Container(
                                width: width * 0.22,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.09),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (i < 2) SizedBox(height: width * 0.06),
                  ],
                  const Spacer(),
                  Container(
                    height: width * 0.16,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.035),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var i = 0; i < 3; i++)
                          Container(
                            width: width * 0.08,
                            height: width * 0.08,
                            decoration: BoxDecoration(
                              color: i == 0
                                  ? Brand.cyan.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniChartPainter extends CustomPainter {
  _MiniChartPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.72)
      ..cubicTo(
        size.width * 0.15,
        size.height * 0.5,
        size.width * 0.3,
        size.height * 0.8,
        size.width * 0.45,
        size.height * 0.55,
      )
      ..cubicTo(
        size.width * 0.62,
        size.height * 0.25,
        size.width * 0.75,
        size.height * 0.6,
        size.width,
        size.height * 0.3,
      );
    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _MiniChartPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _TerminalVisual extends StatelessWidget {
  const _TerminalVisual();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.min(292.0, constraints.maxWidth - 40);
        return Stack(
          children: [
            Positioned(
              top: 60,
              right: 24,
              child: Container(
                width: width,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xD90A0E17),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Brand.violet.withValues(alpha: 0.14),
                      blurRadius: 34,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (final c in [
                          const Color(0xFFFF6B6B),
                          const Color(0xFFFFD93D),
                          const Color(0xFF6BCB77),
                        ])
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: c.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        const Spacer(),
                        Text(
                          'naf / build',
                          style: T.mono(
                            6,
                            color: Brand.dim,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _TerminalLine(
                      prompt: '\$',
                      text: 'naf deploy --prod',
                      color: Brand.ink,
                    ),
                    const SizedBox(height: 7),
                    _TerminalLine(
                      prompt: '✓',
                      text: 'build complete',
                      color: Brand.lime,
                    ),
                    const SizedBox(height: 7),
                    _TerminalLine(
                      prompt: '✓',
                      text: 'systems connected',
                      color: Brand.lime,
                    ),
                    const SizedBox(height: 7),
                    _TerminalLine(
                      prompt: '→',
                      text: 'live. ship it.',
                      color: Brand.cyan,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 46,
              child: Text(
                '{ }',
                style: T.display(
                  72,
                  weight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.045),
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TerminalLine extends StatelessWidget {
  const _TerminalLine({
    required this.prompt,
    required this.text,
    required this.color,
  });

  final String prompt;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 12,
          child: Text(
            prompt,
            style: T.mono(8, color: Brand.violet, letterSpacing: 0),
          ),
        ),
        Text(text, style: T.mono(8.2, color: color, letterSpacing: 0.2)),
      ],
    );
  }
}

class _BrowserVisual extends StatelessWidget {
  const _BrowserVisual();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.min(280.0, constraints.maxWidth - 44);
        return Stack(
          children: [
            Positioned(
              top: 36,
              left: (constraints.maxWidth - width) / 2,
              child: Transform.rotate(
                angle: -0.035,
                child: Container(
                  width: width,
                  height: width * 0.62,
                  decoration: BoxDecoration(
                    color: const Color(0xE60A0E17),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 22,
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0x12FFFFFF)),
                          ),
                        ),
                        child: Row(
                          children: [
                            for (final color in [
                              Brand.magenta,
                              Brand.violet,
                              Brand.cyan,
                            ])
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.55),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Container(
                                height: 10,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  'newagefactories.com',
                                  style: T.mono(
                                    5.3,
                                    color: Brand.dim,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width * 0.28,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient: Brand.signature,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      width: width * 0.38,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.72,
                                        ),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Container(
                                      width: width * 0.30,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.72,
                                        ),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: width * 0.18,
                                      height: 11,
                                      decoration: BoxDecoration(
                                        gradient: Brand.signature,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width * 0.27,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0x3346E7FF),
                                      Color(0x228B6CFF),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.06),
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: width * 0.10,
                                    height: width * 0.10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Brand.cyan.withValues(
                                          alpha: 0.35,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_outward_rounded,
                                      size: width * 0.045,
                                      color: Brand.cyan,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 18,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Brand.line),
                  color: Colors.white.withValues(alpha: 0.025),
                ),
                child: const Icon(
                  Icons.public_rounded,
                  size: 13,
                  color: Brand.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CommerceVisual extends StatelessWidget {
  const _CommerceVisual();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 26,
          right: 24,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xD90A0E17),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Brand.magenta.withValues(alpha: 0.24)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  size: 10,
                  color: Brand.magenta,
                ),
                const SizedBox(width: 6),
                Text(
                  'ORDER → SHIPPED',
                  style: T.mono(
                    6.5,
                    color: const Color(0xFFFFC1D8),
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 62,
          right: 52,
          child: Container(
            width: 72,
            height: 1,
            decoration: const BoxDecoration(gradient: Brand.signature),
          ),
        ),
      ],
    );
  }
}

class _NetworkVisual extends StatelessWidget {
  const _NetworkVisual();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 22,
          top: 20,
          child: SizedBox(
            width: 110,
            height: 110,
            child: CustomPaint(painter: _NodePainter(color: Brand.lime)),
          ),
        ),
        Positioned(
          top: 30,
          right: 26,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xD9080D15),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Brand.lime.withValues(alpha: 0.2)),
            ),
            child: Text(
              'CONNECTED',
              style: T.mono(6, color: Brand.lime, letterSpacing: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}

class _NodePainter extends CustomPainter {
  _NodePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final nodePaint = Paint()..color = color.withValues(alpha: 0.7);
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..strokeWidth = 0.8;

    final points = <Offset>[
      Offset(size.width * 0.16, size.height * 0.28),
      Offset(size.width * 0.74, size.height * 0.16),
      Offset(size.width * 0.86, size.height * 0.65),
      Offset(size.width * 0.42, size.height * 0.84),
      Offset(size.width * 0.12, size.height * 0.66),
    ];
    canvas.drawCircle(
      center,
      23,
      Paint()
        ..color = color.withValues(alpha: 0.05)
        ..style = PaintingStyle.fill,
    );
    for (final p in points) {
      canvas.drawLine(center, p, linePaint);
    }
    canvas.drawCircle(center, 3.5, nodePaint);
    for (var i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], i.isEven ? 2.2 : 1.5, nodePaint);
    }
    canvas.drawCircle(
      center,
      15,
      Paint()
        ..color = color.withValues(alpha: 0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7,
    );
    canvas.drawCircle(
      center,
      31,
      Paint()
        ..color = color.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7,
    );
  }

  @override
  bool shouldRepaint(covariant _NodePainter oldDelegate) =>
      oldDelegate.color != color;
}

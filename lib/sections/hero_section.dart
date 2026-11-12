import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onExploreWork,
    required this.onStartProject,
    required this.onOpenProduct,
  });

  final VoidCallback onExploreWork;
  final VoidCallback onStartProject;
  final VoidCallback onOpenProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SiteBody(
          padding: const EdgeInsets.only(top: 148, bottom: 72),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final wide = w >= 980;
              final left = _HeroCopy(
                onExploreWork: onExploreWork,
                onStartProject: onStartProject,
                wide: wide,
                width: w,
              );
              final stage = _HeroStage(
                onOpenProduct: onOpenProduct,
                wide: wide,
              );
              return wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 55, child: left),
                        const SizedBox(width: 56),
                        Expanded(flex: 45, child: stage),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [left, const SizedBox(height: 52), stage],
                    );
            },
          ),
        ),
        const _CapabilityTicker(),
      ],
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.onExploreWork,
    required this.onStartProject,
    required this.wide,
    required this.width,
  });

  final VoidCallback onExploreWork;
  final VoidCallback onStartProject;
  final bool wide;
  final double width;

  double get _displaySize {
    if (width >= 1180) return 78;
    if (width >= 980) return 64;
    if (width >= 720) return 60;
    if (width < 390) return 40;
    return 44;
  }

  @override
  Widget build(BuildContext context) {
    final display = _displaySize;
    final bodySize = wide ? 16.5 : 15.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.025),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Brand.line),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Brand.lime,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Brand.lime.withValues(alpha: 0.6),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  'DIGITAL PRODUCT STUDIO',
                  style: T.mono(
                    9.5,
                    color: const Color(0xFFB7C2D4),
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(width: 10),
                Container(width: 1, height: 10, color: Brand.lineStrong),
                const SizedBox(width: 10),
                Text(
                  'LLC',
                  style: T.mono(9.5, color: Brand.dim, letterSpacing: 1.8),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                'Digital products',
                style: T.display(display, height: 0.98),
              ),
              Text('built to move', style: T.display(display, height: 1.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      'business forward.',
                      style: T.display(display, height: 1.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: display * 0.12),
                    child: _BlinkingBlock(size: display * 0.13),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 160),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 525),
            child: Text(
              'New Age Factories is a digital solutions studio. We design and engineer mobile apps, websites, e-commerce and connected systems — from the first sketch to the store, the cloud and beyond.',
              style: T.body(bodySize, color: Brand.muted, height: 1.7),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Reveal(
          delay: const Duration(milliseconds: 240),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              NafButton(label: 'Explore our work', onPressed: onExploreWork),
              NafButton(
                label: 'Start a project',
                style: NafButtonStyle.outline,
                icon: Icons.north_east_rounded,
                onPressed: onStartProject,
              ),
            ],
          ),
        ),
        const SizedBox(height: 44),
        Reveal(
          delay: const Duration(milliseconds: 320),
          child: Container(
            padding: const EdgeInsets.only(top: 22),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Brand.line)),
            ),
            child: Wrap(
              spacing: 34,
              runSpacing: 18,
              children: const [
                _HeroStat(value: '05', label: 'DIGITAL DISCIPLINES'),
                _HeroStat(value: '02', label: 'APPS IN THE OJRA SUITE'),
                _HeroStat(value: '01', label: 'PARTNER, IDEA TO LAUNCH'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: T.display(22, weight: FontWeight.w600, color: Brand.ink),
        ),
        const SizedBox(width: 9),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 110),
          child: Text(
            label,
            style: T.mono(
              8,
              color: Brand.dim,
              letterSpacing: 1.25,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _BlinkingBlock extends StatefulWidget {
  const _BlinkingBlock({required this.size});

  final double size;

  @override
  State<_BlinkingBlock> createState() => _BlinkingBlockState();
}

class _BlinkingBlockState extends State<_BlinkingBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (reduceMotion(context)) {
      return Container(
        width: widget.size,
        height: widget.size,
        color: Brand.lime,
      );
    }
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.18,
        end: 1,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Brand.lime, Brand.cyan]),
          boxShadow: [
            BoxShadow(color: Brand.lime.withValues(alpha: 0.3), blurRadius: 16),
          ],
        ),
      ),
    );
  }
}

class _HeroStage extends StatefulWidget {
  const _HeroStage({required this.onOpenProduct, required this.wide});

  final VoidCallback onOpenProduct;
  final bool wide;

  @override
  State<_HeroStage> createState() => _HeroStageState();
}

class _HeroStageState extends State<_HeroStage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _routeController;
  double _rotateX = 0;
  double _rotateY = 0;
  Duration _tiltDuration = const Duration(milliseconds: 240);

  @override
  void initState() {
    super.initState();
    _routeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _routeController.dispose();
    super.dispose();
  }

  void _onHover(PointerHoverEvent event) {
    final box = context.findRenderObject();
    if (box is! RenderBox) return;
    final nx = (event.localPosition.dx / box.size.width - 0.5).clamp(-0.5, 0.5);
    final ny = (event.localPosition.dy / box.size.height - 0.5).clamp(
      -0.5,
      0.5,
    );
    setState(() {
      _rotateX = -ny * 0.035;
      _rotateY = nx * 0.045;
      _tiltDuration = const Duration(milliseconds: 120);
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _tiltDuration = const Duration(milliseconds: 450);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 720;
    final height = widget.wide ? 548.0 : (mobile ? 430.0 : 520.0);
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = (constraints.maxWidth / 540).clamp(0.72, 1.0);
        return MouseRegion(
          onHover: _onHover,
          onExit: _onExit,
          child: AnimatedContainer(
            duration: _tiltDuration,
            curve: Curves.easeOutCubic,
            height: height,
            transformAlignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0011)
              ..rotateX(_rotateX)
              ..rotateY(_rotateY),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 10,
                  right: -34,
                  child: IgnorePointer(
                    child: Container(
                      width: 280 * scale,
                      height: 280 * scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Brand.violet.withValues(alpha: 0.2),
                            Brand.cyan.withValues(alpha: 0.06),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      border: Border.all(color: Brand.line),
                      gradient: Brand.surfaceGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 80,
                          spreadRadius: -20,
                          offset: const Offset(0, 35),
                        ),
                        BoxShadow(
                          color: Brand.cyan.withValues(alpha: 0.07),
                          blurRadius: 70,
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/hero_earth.jpg',
                            fit: BoxFit.cover,
                            semanticLabel:
                                'Satellite view of illuminated cities at night',
                          ),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0x22050A12),
                                  Color(0x99050A12),
                                  Color(0xF205070E),
                                ],
                                stops: [0, 0.55, 1],
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Brand.cyan.withValues(alpha: 0.12),
                                  Colors.transparent,
                                  Brand.violet.withValues(alpha: 0.16),
                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(
                                painter: _RoutePainter(
                                  progress: _routeController,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 18,
                            left: 18,
                            child: GlassPill(
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
                                          color: Brand.lime.withValues(
                                            alpha: 0.7,
                                          ),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    'LIVE NETWORK',
                                    style: T.mono(
                                      7.8,
                                      color: const Color(0xFFD7E1F0),
                                      letterSpacing: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 21,
                            right: 20,
                            child: Text(
                              'NAF / 01',
                              style: T.mono(
                                8,
                                color: Brand.dim,
                                letterSpacing: 1.6,
                              ),
                            ),
                          ),
                          if (widget.wide)
                            Positioned(
                              left: -26,
                              top: height * 0.30,
                              child: const _FloatingDispatchCard(),
                            ),
                          Positioned(
                            right: 22,
                            top: height * 0.26,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xB30A0F18),
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Brand.line),
                              ),
                              child: Text(
                                'IOS · ANDROID · WEB',
                                style: T.mono(
                                  7.2,
                                  color: Brand.cyan,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            right: 18,
                            bottom: 18,
                            child: _ProductCard(onTap: widget.onOpenProduct),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -18,
                  left: widget.wide ? -10 : 24,
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Brand.cyan,
                        boxShadow: [
                          BoxShadow(
                            color: Brand.cyan.withValues(alpha: 0.65),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FloatingDispatchCard extends StatefulWidget {
  const _FloatingDispatchCard();

  @override
  State<_FloatingDispatchCard> createState() => _FloatingDispatchCardState();
}

class _FloatingDispatchCardState extends State<_FloatingDispatchCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offset = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    final card = Container(
      width: 202,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xF20B1019),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 38,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt_rounded, size: 12, color: Brand.cyan),
              const SizedBox(width: 5),
              Text(
                'LIVE DISPATCH',
                style: T.mono(7, color: Brand.muted, letterSpacing: 1.2),
              ),
              const Spacer(),
              Text(
                'NOW',
                style: T.mono(6.5, color: Brand.lime, letterSpacing: 0.8),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Nearby drivers matched in seconds.',
            style: T.body(
              10.5,
              color: Brand.ink,
              height: 1.35,
              weight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.72,
                    minHeight: 3,
                    backgroundColor: Colors.white.withValues(alpha: 0.06),
                    valueColor: const AlwaysStoppedAnimation(Brand.cyan),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '72%',
                style: T.mono(6.5, color: Brand.dim, letterSpacing: 0.4),
              ),
            ],
          ),
        ],
      ),
    );
    if (reduceMotion(context)) return card;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, offset.value),
          child: child,
        );
      },
      child: card,
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onTap,
      builder: (context, hovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xF20A0E17),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hovered
                  ? Brand.ojra.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.11),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: Brand.ojraGradient,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: Brand.ojra.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/ojra_wordmark.png',
                  fit: BoxFit.contain,
                  semanticLabel: 'Ojra',
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'OJRA',
                          style: T.display(14, weight: FontWeight.w600),
                        ),
                        const SizedBox(width: 7),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Brand.ojra,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'CASE STUDY',
                          style: T.mono(
                            6.5,
                            color: Brand.dim,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rider + Driver · Live on Google Play',
                      style: T.body(9.5, color: Brand.muted, height: 1.2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hovered
                      ? Brand.ojra.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.04),
                  border: Border.all(color: Brand.line),
                ),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  size: 14,
                  color: hovered ? const Color(0xFFFFA7C4) : Brand.ink,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RoutePainter extends CustomPainter {
  _RoutePainter({required this.progress}) : super(repaint: progress);

  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.02, size.height * 0.66)
      ..cubicTo(
        size.width * 0.23,
        size.height * 0.50,
        size.width * 0.35,
        size.height * 0.62,
        size.width * 0.51,
        size.height * 0.47,
      )
      ..cubicTo(
        size.width * 0.68,
        size.height * 0.32,
        size.width * 0.76,
        size.height * 0.45,
        size.width * 0.98,
        size.height * 0.20,
      );

    final shader = LinearGradient(
      colors: [
        Brand.cyan.withValues(alpha: 0.0),
        Brand.cyan.withValues(alpha: 0.45),
        Brand.violet.withValues(alpha: 0.4),
        Colors.transparent,
      ],
      stops: const [0, 0.18, 0.75, 1],
    ).createShader(Offset.zero & size);

    canvas.drawPath(
      path,
      Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9),
    );
    canvas.drawPath(
      path,
      Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );

    final metric = path.computeMetrics().first;
    for (final t in [0.15, 0.31, 0.48, 0.64, 0.8]) {
      final tangent = metric.getTangentForOffset(metric.length * t);
      if (tangent == null) continue;
      canvas.drawCircle(
        tangent.position,
        2,
        Paint()..color = Colors.white.withValues(alpha: 0.65),
      );
      canvas.drawCircle(
        tangent.position,
        5.5,
        Paint()..color = Brand.cyan.withValues(alpha: 0.08),
      );
    }

    final head = metric.getTangentForOffset(
      metric.length * (0.1 + progress.value * 0.8),
    );
    if (head != null) {
      canvas.drawCircle(
        head.position,
        11,
        Paint()..color = Brand.cyan.withValues(alpha: 0.11),
      );
      canvas.drawCircle(
        head.position,
        4.5,
        Paint()..color = Brand.cyan.withValues(alpha: 0.22),
      );
      canvas.drawCircle(head.position, 1.8, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => false;
}

class _CapabilityTicker extends StatelessWidget {
  const _CapabilityTicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x66070A12),
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.white.withValues(alpha: 0.07)),
        ),
      ),
      child: Column(
        children: [
          SiteBody(
            child: SizedBox(
              height: 34,
              child: Row(
                children: [
                  Text(
                    'WHAT WE BUILD',
                    style: T.mono(8, color: Brand.dim, letterSpacing: 1.8),
                  ),
                  const Spacer(),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Brand.cyan,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'FULL-STACK DIGITAL',
                    style: T.mono(8, color: Brand.dim, letterSpacing: 1.8),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0x0FFFFFFF))),
            ),
            child: const MarqueeStrip(
              items: [
                'Mobile apps',
                'Websites',
                'E-commerce',
                'Digital solutions',
                'Networking',
                'Product engineering',
              ],
            ),
          ),
        ],
      ),
    );
  }
}

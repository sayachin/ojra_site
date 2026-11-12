import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme.dart';

bool reduceMotion(BuildContext context) {
  return MediaQuery.maybeDisableAnimationsOf(context) ?? false;
}

/// Constrains content to the site grid and adds responsive gutters.
class SiteBody extends StatelessWidget {
  const SiteBody({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth = kMaxContentWidth,
  });

  final Widget child;
  final EdgeInsets? padding;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final gutter = gutterFor(width);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: gutter,
      ).add(padding ?? EdgeInsets.zero),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

/// Fades and lifts children into view as the page is scrolled.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 28),
    this.duration = const Duration(milliseconds: 700),
  });

  final Widget child;
  final Duration delay;
  final Offset offset;
  final Duration duration;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  ScrollPosition? _position;
  Timer? _delayTimer;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(curve);
    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reduceMotion(context)) {
      _show(immediate: true);
      return;
    }
    final position = Scrollable.maybeOf(context)?.position;
    if (position != _position) {
      _position?.removeListener(_check);
      _position = position;
      _position?.addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!mounted || _visible) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    if (top < MediaQuery.sizeOf(context).height * 0.94) {
      _show();
    }
  }

  void _show({bool immediate = false}) {
    if (_visible || !mounted) return;
    _visible = true;
    _position?.removeListener(_check);
    if (immediate) {
      _controller.value = 1;
      return;
    }
    if (widget.delay == Duration.zero) {
      _controller.forward();
      return;
    }
    _delayTimer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _position?.removeListener(_check);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value == 1) return widget.child;
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value,
          child: Transform.translate(offset: _slide.value, child: child),
        );
      },
    );
  }
}

/// Exposes hover state to a card while keeping pointer handling in one place.
class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.cursor = SystemMouseCursors.basic,
  });

  final Widget Function(BuildContext context, bool hovered) builder;
  final VoidCallback? onTap;
  final MouseCursor cursor;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final child = MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : widget.cursor,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: widget.builder(context, _hovered),
      ),
    );
    if (widget.onTap == null) return child;
    return Semantics(button: true, child: child);
  }
}

class SectionEyebrow extends StatelessWidget {
  const SectionEyebrow(
    this.index,
    this.label, {
    super.key,
    this.color = Brand.muted,
  });

  final String index;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '[ $index ]',
          style: T.mono(10.5, color: Brand.cyan, letterSpacing: 1.4),
        ),
        const SizedBox(width: 14),
        Container(width: 22, height: 1, color: Brand.lineStrong),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            label.toUpperCase(),
            style: T.mono(10.5, color: color, letterSpacing: 2.1),
          ),
        ),
      ],
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.gradient = Brand.signature,
    this.textAlign,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(
    this.label, {
    super.key,
    this.color = Brand.muted,
    this.dotColor,
  });

  final String label;
  final Color color;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Brand.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
          ],
          Text(
            label.toUpperCase(),
            style: T.mono(9, color: color, letterSpacing: 1.15),
          ),
        ],
      ),
    );
  }
}

enum NafButtonStyle { primary, outline, quiet }

class NafButton extends StatefulWidget {
  const NafButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = NafButtonStyle.primary,
    this.icon = Icons.arrow_outward_rounded,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final NafButtonStyle style;
  final IconData? icon;
  final bool compact;

  @override
  State<NafButton> createState() => _NafButtonState();
}

class _NafButtonState extends State<NafButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.style == NafButtonStyle.primary;
    final isQuiet = widget.style == NafButtonStyle.quiet;
    final height = widget.compact ? 44.0 : 52.0;
    final textColor = isPrimary ? const Color(0xFF031018) : Brand.ink;

    final decoration = isPrimary
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: _hovered
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF7DF3FF), Brand.cyan, Brand.violet],
                  )
                : Brand.signature,
            boxShadow: [
              BoxShadow(
                color: Brand.cyan.withValues(alpha: _hovered ? 0.25 : 0.1),
                blurRadius: _hovered ? 34 : 20,
                spreadRadius: _hovered ? 2 : 0,
                offset: const Offset(0, 8),
              ),
            ],
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _hovered
                ? (isQuiet
                      ? Colors.white.withValues(alpha: 0.05)
                      : Brand.cyan.withValues(alpha: 0.06))
                : Colors.transparent,
            border: isQuiet
                ? null
                : Border.all(
                    color: _hovered
                        ? Brand.cyan.withValues(alpha: 0.42)
                        : Brand.lineStrong,
                  ),
          );

    return Semantics(
      button: true,
      label: widget.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (value) => setState(() => _hovered = value),
          borderRadius: BorderRadius.circular(8),
          hoverColor: Colors.transparent,
          splashColor: (isPrimary ? Colors.black : Brand.cyan).withValues(
            alpha: 0.08,
          ),
          highlightColor: Colors.transparent,
          focusColor: Brand.cyan.withValues(alpha: 0.08),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: widget.compact ? 16 : 22),
            transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
            decoration: decoration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: T.body(
                    14,
                    weight: FontWeight.w600,
                    color: textColor,
                    letterSpacing: 0.1,
                  ),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 10),
                  Transform.translate(
                    offset: Offset(_hovered ? 3 : 0, _hovered ? -3 : 0),
                    child: Icon(
                      widget.icon,
                      size: 17,
                      color: isPrimary ? const Color(0xFF031018) : Brand.cyan,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArrowLink extends StatefulWidget {
  const ArrowLink({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Brand.ink,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  State<ArrowLink> createState() => _ArrowLinkState();
}

class _ArrowLinkState extends State<ArrowLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          onHover: (v) => setState(() => _hovered = v),
          borderRadius: BorderRadius.circular(4),
          hoverColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: T.body(
                        13.5,
                        weight: FontWeight.w600,
                        color: widget.color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Transform.translate(
                      offset: Offset(_hovered ? 4 : 0, 0),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: _hovered ? Brand.cyan : widget.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  height: 1,
                  width: _hovered ? 100 : 28,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Brand.cyan.withValues(alpha: _hovered ? 1 : 0.4),
                        Brand.violet.withValues(alpha: _hovered ? 1 : 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 38});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'New Age Factories',
      image: true,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.27),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0x7746E7FF), Color(0x12FFFFFF), Color(0x668B6CFF)],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.24),
            color: Brand.bgSoft,
          ),
          child: CustomPaint(painter: _BrandMarkPainter()),
        ),
      ),
    );
  }
}

class _BrandMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final shader = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Brand.cyan, Brand.violet, Brand.magenta],
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    final stroke = Paint()
      ..shader = shader
      ..strokeWidth = w * 0.075
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(w * 0.29, h * 0.71)
      ..lineTo(w * 0.29, h * 0.29)
      ..lineTo(w * 0.71, h * 0.71)
      ..lineTo(w * 0.71, h * 0.29);
    canvas.drawPath(path, stroke);

    canvas.drawCircle(
      Offset(w * 0.71, h * 0.29),
      w * 0.062,
      Paint()..color = Brand.lime,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BrandWordmark extends StatelessWidget {
  const BrandWordmark({super.key, this.markSize = 38, this.compact = false});

  final double markSize;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandMark(size: markSize),
        const SizedBox(width: 11),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NEW AGE',
              style: T.display(
                compact ? 12.5 : 14,
                weight: FontWeight.w600,
                letterSpacing: compact ? 2.2 : 2.6,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'FACTORIES LLC',
              style: T.mono(
                compact ? 6.8 : 7.6,
                color: Brand.dim,
                letterSpacing: compact ? 1.6 : 2.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MarqueeStrip extends StatefulWidget {
  const MarqueeStrip({
    super.key,
    required this.items,
    this.height = 62,
    this.itemWidth = 280,
    this.duration = const Duration(seconds: 36),
    this.reverse = false,
  });

  final List<String> items;
  final double height;
  final double itemWidth;
  final Duration duration;
  final bool reverse;

  @override
  State<MarqueeStrip> createState() => _MarqueeStripState();
}

class _MarqueeStripState extends State<MarqueeStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = widget.itemWidth * widget.items.length;
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var set = 0; set < 2; set++)
          for (final item in widget.items)
            SizedBox(
              width: widget.itemWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: Brand.signature,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    item.toUpperCase(),
                    style: T.mono(
                      11,
                      color: const Color(0xFF8995AB),
                      letterSpacing: 2.6,
                    ),
                  ),
                ],
              ),
            ),
      ],
    );

    return ClipRect(
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white,
              Colors.white,
              Colors.transparent,
            ],
            stops: [0, 0.07, 0.93, 1],
          ).createShader(bounds),
          blendMode: BlendMode.dstIn,
          child: reduceMotion(context)
              ? OverflowBox(
                  alignment: Alignment.centerLeft,
                  maxWidth: double.infinity,
                  child: Row(
                    children: [
                      for (final item in widget.items)
                        SizedBox(
                          width: widget.itemWidth,
                          child: Text(
                            item.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: T.mono(
                              11,
                              color: Brand.muted,
                              letterSpacing: 2.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = _controller.value;
                    final shift = widget.reverse ? t : -t;
                    return Transform.translate(
                      offset: Offset(shift * totalWidth, 0),
                      child: OverflowBox(
                        alignment: Alignment.centerLeft,
                        maxWidth: double.infinity,
                        child: content,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class GlassPill extends StatelessWidget {
  const GlassPill({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.color = const Color(0xAA080D17),
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Colors.white.withValues(alpha: 0.11)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Background drawn once behind the scroll view: grid, glows and vignette.
class BackdropPainter extends CustomPainter {
  const BackdropPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF060912), Color(0xFF04060C)],
      ).createShader(rect);
    canvas.drawRect(rect, base);

    void glow(Offset center, double radius, Color color) {
      final paint = Paint()
        ..shader = ui.Gradient.radial(
          center,
          radius,
          [color, color.withValues(alpha: 0)],
          [0.0, 1.0],
        );
      canvas.drawCircle(center, radius, paint);
    }

    glow(
      Offset(size.width * 0.86, size.height * 0.08),
      size.width * 0.44,
      const Color(0x2B1E8CA8),
    );
    glow(
      Offset(size.width * 0.04, size.height * 0.32),
      size.width * 0.38,
      const Color(0x221F125C),
    );

    final grid = Paint()..color = Colors.white.withValues(alpha: 0.028);
    const step = 64.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawRect(Rect.fromLTWH(x, 0, 1, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), grid);
    }

    final dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.055);
    for (double x = 0; x < size.width; x += step * 2) {
      for (double y = 0; y < size.height; y += step * 2) {
        canvas.drawCircle(Offset(x, y), 1, dotPaint);
      }
    }

    final vignette = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height * 0.4),
        math.max(size.width, size.height) * 0.8,
        [Colors.transparent, Brand.bg.withValues(alpha: 0.7)],
        [0.5, 1.0],
      );
    canvas.drawRect(rect, vignette);
  }

  @override
  bool shouldRepaint(covariant BackdropPainter oldDelegate) => false;
}

/// Small crosshair / corner ticks used on feature panels.
class CornerTicks extends StatelessWidget {
  const CornerTicks({super.key, this.size = 12, this.color = Brand.lineStrong});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CornerTicksPainter(size: size, color: color),
      size: Size.infinite,
    );
  }
}

class _CornerTicksPainter extends CustomPainter {
  _CornerTicksPainter({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    final w = canvasSize.width;
    final h = canvasSize.height;
    // top-left
    canvas.drawLine(Offset.zero, Offset(size, 0), paint);
    canvas.drawLine(Offset.zero, Offset(0, size), paint);
    // top-right
    canvas.drawLine(Offset(w - size, 0), Offset(w, 0), paint);
    canvas.drawLine(Offset(w - 1, 0), Offset(w - 1, size), paint);
    // bottom-left
    canvas.drawLine(Offset(0, h - 1), Offset(size, h - 1), paint);
    canvas.drawLine(Offset(0, h - size), Offset(0, h), paint);
    // bottom-right
    canvas.drawLine(Offset(w - size, h - 1), Offset(w, h - 1), paint);
    canvas.drawLine(Offset(w - 1, h - size), Offset(w - 1, h), paint);
  }

  @override
  bool shouldRepaint(covariant _CornerTicksPainter oldDelegate) =>
      oldDelegate.size != size || oldDelegate.color != color;
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteBody(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Brand.lineStrong,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 4,
            height: 4,
            transform: Matrix4.rotationZ(math.pi / 4),
            color: Brand.dim,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

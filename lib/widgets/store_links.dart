import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../content.dart';
import '../theme.dart';

/// True when the visitor is on a phone or tablet browser, where a store link
/// can hand off straight to the Play Store app.
bool get isMobileStoreVisitor =>
    defaultTargetPlatform == TargetPlatform.android ||
    defaultTargetPlatform == TargetPlatform.iOS;

Future<bool> _launchStore(String url) async {
  try {
    return await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {
    return false;
  }
}

/// On phones this opens Google Play. On desktop it shows a scannable QR code
/// instead, so the visitor can install the app without typing a URL.
Future<void> openStoreUrl(
  BuildContext context,
  String url, {
  required String app,
}) async {
  if (isMobileStoreVisitor) {
    final launched = await _launchStore(url);
    if (!launched && context.mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          content: Text(
            'Find $app on Google Play',
            style: T.body(13, color: Brand.ink),
          ),
          backgroundColor: Brand.surfaceRaised,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    return;
  }
  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.74),
    builder: (_) => _StoreQrDialog(app: app, url: url),
  );
}

class _StoreQrDialog extends StatelessWidget {
  const _StoreQrDialog({required this.app, required this.url});

  final String app;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 22),
          decoration: BoxDecoration(
            color: const Color(0xFF090C14),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.11)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 60,
                offset: const Offset(0, 24),
              ),
              BoxShadow(
                color: Brand.ojra.withValues(alpha: 0.08),
                blurRadius: 60,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      gradient: Brand.ojraGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const _PlayGlyph(size: 16),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          app.toUpperCase(),
                          style: T.mono(
                            8,
                            color: Brand.dim,
                            letterSpacing: 1.4,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Install from Google Play',
                          style: T.body(
                            14,
                            weight: FontWeight.w600,
                            color: Brand.ink,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _CloseButton(onTap: () => Navigator.of(context).pop()),
                ],
              ),
              const SizedBox(height: 20),
              _QrTile(url: url, size: 208, padding: 16),
              const SizedBox(height: 17),
              Text(
                'Scan with your phone camera',
                style: T.body(
                  13,
                  weight: FontWeight.w600,
                  color: Brand.ink,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                'Point your camera at the code to install the app.',
                style: T.body(11.8, color: Brand.muted, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _launchStore(url),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    'Or open the listing in a new tab',
                    style: T.body(
                      11.5,
                      color: Brand.cyan,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CloseButton extends StatefulWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<_CloseButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Close',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered
                  ? Colors.white.withValues(alpha: 0.07)
                  : Colors.transparent,
              border: Border.all(
                color: _hovered ? Brand.lineStrong : Brand.line,
              ),
            ),
            child: Icon(
              Icons.close_rounded,
              size: 14,
              color: _hovered ? Brand.ink : Brand.muted,
            ),
          ),
        ),
      ),
    );
  }
}

class _QrTile extends StatelessWidget {
  const _QrTile({
    required this.url,
    required this.size,
    required this.padding,
    this.errorCorrectionLevel = QrErrorCorrectLevel.M,
  });

  final String url;
  final double size;
  final double padding;
  final int errorCorrectionLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size > 120 ? 12 : 8),
      ),
      child: QrImageView(
        data: url,
        version: QrVersions.auto,
        size: size,
        backgroundColor: Colors.white,
        errorCorrectionLevel: errorCorrectionLevel,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: Color(0xFF070A12),
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: Color(0xFF070A12),
        ),
      ),
    );
  }
}

/// The two live Ojra listings. On phones they are Play Store buttons; on
/// desktop the QR codes are visible immediately, with a larger code on click.
class OjraStoreLinks extends StatelessWidget {
  const OjraStoreLinks({super.key, this.alignment = WrapAlignment.start});

  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final desktop = !isMobileStoreVisitor;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: alignment,
      children: desktop
          ? const [
              _DesktopStoreCard(
                label: 'RIDER APP',
                app: 'Ojra Rider',
                url: kOjraRiderPlayUrl,
              ),
              _DesktopStoreCard(
                label: 'DRIVER APP',
                app: 'Ojra Driver',
                url: kOjraDriverPlayUrl,
              ),
            ]
          : const [
              _StoreItem(
                label: 'RIDER APP',
                app: 'Ojra Rider',
                url: kOjraRiderPlayUrl,
              ),
              _StoreItem(
                label: 'DRIVER APP',
                app: 'Ojra Driver',
                url: kOjraDriverPlayUrl,
              ),
            ],
    );
  }
}

class _DesktopStoreCard extends StatefulWidget {
  const _DesktopStoreCard({
    required this.label,
    required this.app,
    required this.url,
  });

  final String label;
  final String app;
  final String url;

  @override
  State<_DesktopStoreCard> createState() => _DesktopStoreCardState();
}

class _DesktopStoreCardState extends State<_DesktopStoreCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: 'Show QR code for ${widget.app}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => openStoreUrl(context, widget.url, app: widget.app),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 216,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: _hovered
                  ? const Color(0xFF11161F)
                  : const Color(0xFF080B12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _hovered
                    ? Brand.ojra.withValues(alpha: 0.45)
                    : Colors.white.withValues(alpha: 0.13),
              ),
            ),
            child: Row(
              children: [
                _QrTile(
                  url: widget.url,
                  size: 80,
                  padding: 6,
                  errorCorrectionLevel: QrErrorCorrectLevel.L,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: T.mono(
                          6.4,
                          color: Brand.dim,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.app,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: T.body(
                          11.5,
                          weight: FontWeight.w600,
                          color: Brand.ink,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Scan to install',
                            style: T.body(
                              9.2,
                              color: _hovered ? Brand.cyan : Brand.muted,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.north_east_rounded,
                            size: 9,
                            color: _hovered ? Brand.cyan : Brand.dim,
                          ),
                        ],
                      ),
                    ],
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

class _StoreItem extends StatelessWidget {
  const _StoreItem({required this.label, required this.app, required this.url});

  final String label;
  final String app;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: T.mono(7, color: Brand.dim, letterSpacing: 1.4)),
        const SizedBox(height: 6),
        PlayStoreLink(app: app, url: url),
      ],
    );
  }
}

class PlayStoreLink extends StatefulWidget {
  const PlayStoreLink({super.key, required this.app, required this.url});

  final String app;
  final String url;

  @override
  State<PlayStoreLink> createState() => _PlayStoreLinkState();
}

class _PlayStoreLinkState extends State<PlayStoreLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileStoreVisitor;
    return Semantics(
      link: true,
      label: mobile
          ? 'Get ${widget.app} on Google Play'
          : 'Show QR code for ${widget.app}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => openStoreUrl(context, widget.url, app: widget.app),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _hovered
                  ? const Color(0xFF11161F)
                  : const Color(0xFF080B12),
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: _hovered
                    ? Brand.ojra.withValues(alpha: 0.45)
                    : Colors.white.withValues(alpha: 0.13),
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: Brand.ojra.withValues(alpha: 0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _PlayGlyph(size: 17),
                const SizedBox(width: 9),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mobile ? 'GET IT ON' : 'SCAN TO INSTALL',
                      style: T.mono(
                        7.2,
                        color: Brand.dim,
                        letterSpacing: 1.05,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Google Play',
                      style: T.body(
                        12.2,
                        weight: FontWeight.w600,
                        color: Brand.ink,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 9),
                Icon(
                  mobile ? Icons.north_east_rounded : Icons.qr_code_2_rounded,
                  size: mobile ? 11 : 14,
                  color: _hovered ? Brand.cyan : Brand.dim,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayGlyph extends StatelessWidget {
  const _PlayGlyph({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size * 0.82, size),
      painter: const _PlayGlyphPainter(),
    );
  }
}

class _PlayGlyphPainter extends CustomPainter {
  const _PlayGlyphPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(0, size.height)
      ..close();
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Brand.cyan, Brand.lime, Color(0xFFFFC94D), Brand.ojra],
      ).createShader(Offset.zero & size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PlayGlyphPainter oldDelegate) => false;
}

/// A compact external link for the footer's meta row.
class StoreTextLink extends StatefulWidget {
  const StoreTextLink({
    super.key,
    required this.label,
    required this.app,
    required this.url,
  });

  final String label;
  final String app;
  final String url;

  @override
  State<StoreTextLink> createState() => _StoreTextLinkState();
}

class _StoreTextLinkState extends State<StoreTextLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => openStoreUrl(context, widget.url, app: widget.app),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: T.mono(
              8,
              color: _hovered ? Brand.cyan : Brand.dim,
              letterSpacing: 0.8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.label),
                const SizedBox(width: 4),
                Icon(
                  Icons.north_east_rounded,
                  size: 9,
                  color: _hovered ? Brand.cyan : Brand.dim,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

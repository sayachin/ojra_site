import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';

const double _phoneDesignWidth = 250;
const double _phoneDesignHeight = 520;

/// Scales a fixed-size 250x520 app mockup to any width.
class PhoneMockup extends StatelessWidget {
  const PhoneMockup({
    super.key,
    required this.child,
    this.width = 250,
    this.glow = Brand.cyan,
  });

  final Widget child;
  final double width;
  final Color glow;

  @override
  Widget build(BuildContext context) {
    final core = SizedBox(
      width: _phoneDesignWidth,
      height: _phoneDesignHeight,
      child: _PhoneShell(glow: glow, child: child),
    );
    return SizedBox(
      width: width,
      height: width * (_phoneDesignHeight / _phoneDesignWidth),
      child: FittedBox(fit: BoxFit.fill, child: core),
    );
  }
}

class _PhoneShell extends StatelessWidget {
  const _PhoneShell({required this.child, required this.glow});

  final Widget child;
  final Color glow;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(41),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0x664A5B75), Color(0x14FFFFFF), Color(0x334A5B75)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.65),
            blurRadius: 60,
            offset: const Offset(0, 28),
          ),
          BoxShadow(
            color: glow.withValues(alpha: 0.13),
            blurRadius: 48,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(39),
            color: const Color(0xFF08090D),
          ),
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Stack(
              fit: StackFit.expand,
              children: [
                child,
                // Dynamic-island style notch.
                Positioned(
                  top: 7,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 68,
                      height: 19,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.04),
                        ),
                      ),
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

class RiderPhonePreview extends StatelessWidget {
  const RiderPhonePreview({super.key, this.width = 250});

  final double width;

  @override
  Widget build(BuildContext context) {
    return PhoneMockup(
      width: width,
      glow: Brand.cyan,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: Color(0xFF0A0E15)),
          const CustomPaint(painter: _CityMapPainter(driver: false)),
          const Positioned(top: 10, left: 16, right: 16, child: _StatusBar()),
          Positioned(
            top: 34,
            left: 14,
            right: 14,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/ojra_wordmark.png',
                  height: 17,
                  fit: BoxFit.contain,
                ),
                const Spacer(),
                _RoundIcon(
                  icon: Icons.shield_outlined,
                  size: 25,
                  background: const Color(0xCC10141E),
                  iconColor: Brand.ink,
                  iconSize: 11,
                ),
              ],
            ),
          ),
          Positioned(
            top: 70,
            left: 14,
            right: 14,
            child: Container(
              height: 43,
              padding: const EdgeInsets.symmetric(horizontal: 11),
              decoration: BoxDecoration(
                color: const Color(0xF20F131C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, size: 14, color: Brand.cyan),
                  const SizedBox(width: 8),
                  Text(
                    'Where to?',
                    style: T.body(
                      11,
                      color: Brand.ink,
                      weight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Brand.cyan.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'NOW',
                      style: T.mono(6.5, color: Brand.cyan, letterSpacing: 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 154,
            right: 19,
            child: _MapLabel(
              icon: Icons.local_taxi_rounded,
              label: 'Economy · 2 min',
              accent: Brand.cyan,
            ),
          ),
          Positioned(
            top: 187,
            left: 17,
            child: _MapLabel(
              icon: Icons.trip_origin_rounded,
              label: 'Marina Walk',
              accent: Brand.lime,
            ),
          ),
          // Car marker
          Positioned(
            top: 208,
            left: 118,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1019),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: Brand.cyan.withValues(alpha: 0.65),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Brand.cyan.withValues(alpha: 0.32),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.navigation_rounded,
                  color: Brand.cyan,
                  size: 15,
                ),
              ),
            ),
          ),
          const Positioned(left: 0, right: 0, bottom: 0, child: _RiderSheet()),
        ],
      ),
    );
  }
}

class _RiderSheet extends StatelessWidget {
  const _RiderSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 258,
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
      decoration: const BoxDecoration(
        color: Color(0xFF10141D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Color(0x1AFFFFFF))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Driver on the way',
                style: T.display(14.5, weight: FontWeight.w600, height: 1.1),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Brand.lime.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Brand.lime.withValues(alpha: 0.28)),
                ),
                child: Text(
                  '2 MIN',
                  style: T.mono(6.5, color: Brand.lime, letterSpacing: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Brand.cyan.withValues(alpha: 0.2),
                      Brand.violet.withValues(alpha: 0.12),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: Brand.cyan.withValues(alpha: 0.18)),
                ),
                child: const Icon(
                  Icons.directions_car_filled_rounded,
                  color: Brand.cyan,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Economy · Sedan',
                    style: T.body(
                      10,
                      weight: FontWeight.w600,
                      color: Brand.ink,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Plate OJ-2481 · 4 seats',
                    style: T.mono(6.6, color: Brand.dim, letterSpacing: 0.2),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.star_rounded, size: 11, color: Brand.lime),
              const SizedBox(width: 3),
              Text(
                '4.9',
                style: T.body(8.5, weight: FontWeight.w600, color: Brand.ink),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              _ContactAction(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Chat',
              ),
              _ContactAction(icon: Icons.call_outlined, label: 'Call'),
              _ContactAction(icon: Icons.share_outlined, label: 'Share'),
              const Spacer(),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: const Icon(
                  Icons.sos_outlined,
                  size: 14,
                  color: Brand.magenta,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.07)),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  const _RouteDot(color: Brand.lime),
                  Container(
                    width: 1,
                    height: 17,
                    color: Colors.white.withValues(alpha: 0.13),
                  ),
                  const _RouteDot(color: Brand.magenta),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _RouteLine(label: 'Marina Walk', meta: 'Pickup'),
                    const SizedBox(height: 9),
                    _RouteLine(label: 'Central Station', meta: 'Drop-off'),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '4.2 km',
                    style: T.body(
                      9,
                      weight: FontWeight.w600,
                      color: Brand.ink,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '~14 min',
                    style: T.mono(6.6, color: Brand.dim, letterSpacing: 0.2),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 35,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: Brand.signature,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Track your ride',
              style: T.body(
                9.5,
                weight: FontWeight.w700,
                color: const Color(0xFF031018),
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactAction extends StatelessWidget {
  const _ContactAction({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.045),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
            ),
            child: Icon(icon, size: 13, color: Brand.ink),
          ),
          const SizedBox(height: 3),
          Text(label, style: T.body(6.5, color: Brand.dim, height: 1.1)),
        ],
      ),
    );
  }
}

class _RouteDot extends StatelessWidget {
  const _RouteDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.3),
      ),
    );
  }
}

class _RouteLine extends StatelessWidget {
  const _RouteLine({required this.label, required this.meta});

  final String label;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: T.body(
              8.6,
              weight: FontWeight.w500,
              color: Brand.ink,
              height: 1.2,
            ),
          ),
        ),
        Text(
          meta.toUpperCase(),
          style: T.mono(5.8, color: Brand.dim, letterSpacing: 0.8),
        ),
      ],
    );
  }
}

class DriverPhonePreview extends StatelessWidget {
  const DriverPhonePreview({super.key, this.width = 250});

  final double width;

  @override
  Widget build(BuildContext context) {
    return PhoneMockup(
      width: width,
      glow: Brand.ojra,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: Color(0xFF0B0D14)),
          const CustomPaint(painter: _CityMapPainter(driver: true)),
          const Positioned(top: 10, left: 16, right: 16, child: _StatusBar()),
          Positioned(
            top: 34,
            left: 14,
            right: 14,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/ojra_wordmark.png',
                  height: 17,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Brand.ojra.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Brand.ojra.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'DRIVER',
                    style: T.mono(
                      5.5,
                      color: const Color(0xFFFFA7C4),
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const Spacer(),
                _RoundIcon(
                  icon: Icons.notifications_none_rounded,
                  size: 25,
                  background: const Color(0xCC10141E),
                  iconColor: Brand.ink,
                  iconSize: 11,
                ),
              ],
            ),
          ),
          Positioned(
            top: 70,
            left: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xEB0F121B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Brand.lime,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Brand.lime, blurRadius: 6),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "You're online",
                        style: T.body(
                          9.5,
                          weight: FontWeight.w600,
                          color: Brand.ink,
                          height: 1.1,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 24,
                        height: 13,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Brand.lime.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              color: Brand.lime,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      _DriverStat(value: '12', label: 'TRIPS'),
                      _DriverStatDivider(),
                      _DriverStat(value: '6.4h', label: 'ONLINE'),
                      _DriverStatDivider(),
                      _DriverStat(value: '4.9', label: 'RATING'),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Brand.lime.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'GOOD DAY',
                          style: T.mono(
                            5.4,
                            color: Brand.lime,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 156,
            left: 18,
            child: _MapLabel(
              icon: Icons.bolt_rounded,
              label: 'High demand zone',
              accent: Brand.ojra,
            ),
          ),
          Positioned(
            top: 187,
            right: 22,
            child: Transform.rotate(
              angle: 0.55,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF18101A),
                  shape: BoxShape.circle,
                  border: Border.all(color: Brand.ojra.withValues(alpha: 0.7)),
                  boxShadow: [
                    BoxShadow(
                      color: Brand.ojra.withValues(alpha: 0.3),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.navigation_rounded,
                  color: Color(0xFFFF89B0),
                  size: 14,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 249,
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
              decoration: const BoxDecoration(
                color: Color(0xFF10121B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: Color(0x1AFFFFFF))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 32,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Text(
                        'New ride request',
                        style: T.display(
                          14.5,
                          weight: FontWeight.w600,
                          height: 1.1,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 25,
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Brand.ojra.withValues(alpha: 0.45),
                          ),
                        ),
                        child: Text(
                          '12',
                          style: T.mono(
                            7.5,
                            color: const Color(0xFFFF89B0),
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.032),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.06),
                      ),
                    ),
                    child: Column(
                      children: [
                        _DriverRouteRow(
                          color: Brand.lime,
                          label: 'Marina Walk',
                          meta: '2.4 km away',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.5),
                          child: Row(
                            children: [
                              Container(
                                width: 1,
                                height: 13,
                                color: Colors.white.withValues(alpha: 0.14),
                              ),
                            ],
                          ),
                        ),
                        _DriverRouteRow(
                          color: Brand.ojra,
                          label: 'Central Station',
                          meta: '8.1 km trip',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      const Icon(
                        Icons.straighten_rounded,
                        size: 10,
                        color: Brand.dim,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '8.1 km · ~18 min',
                        style: T.mono(
                          6.6,
                          color: Brand.dim,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'EST. EARNINGS',
                        style: T.mono(
                          5.6,
                          color: Brand.dim,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '1,240 DA',
                        style: T.body(
                          9,
                          weight: FontWeight.w700,
                          color: Brand.ink,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                          child: Text(
                            'Decline',
                            style: T.body(
                              9.5,
                              weight: FontWeight.w600,
                              color: Brand.muted,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: Brand.ojraGradient,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Brand.ojra.withValues(alpha: 0.26),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Text(
                            'Accept ride',
                            style: T.body(
                              9.5,
                              weight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverStat extends StatelessWidget {
  const _DriverStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: T.display(13, weight: FontWeight.w600, height: 1.0)),
        const SizedBox(height: 3),
        Text(label, style: T.mono(5.2, color: Brand.dim, letterSpacing: 0.7)),
      ],
    );
  }
}

class _DriverStatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 22,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white.withValues(alpha: 0.07),
    );
  }
}

class _DriverRouteRow extends StatelessWidget {
  const _DriverRouteRow({
    required this.color,
    required this.label,
    required this.meta,
  });

  final Color color;
  final String label;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 6),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: T.body(
            8.4,
            weight: FontWeight.w500,
            color: Brand.ink,
            height: 1.1,
          ),
        ),
        const Spacer(),
        Text(meta, style: T.mono(6.2, color: Brand.dim, letterSpacing: 0.2)),
      ],
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '9:41',
          style: T.body(
            7.2,
            weight: FontWeight.w600,
            color: Brand.ink,
            height: 1,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.signal_cellular_alt_rounded,
          size: 8,
          color: Brand.ink,
        ),
        const SizedBox(width: 3),
        const Icon(Icons.wifi_rounded, size: 8, color: Brand.ink),
        const SizedBox(width: 3),
        const Icon(Icons.battery_full_rounded, size: 9, color: Brand.ink),
      ],
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({
    required this.icon,
    required this.size,
    required this.background,
    required this.iconColor,
    required this.iconSize,
  });

  final IconData icon;
  final double size;
  final Color background;
  final Color iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
      ),
      child: Icon(icon, size: iconSize, color: iconColor),
    );
  }
}

class _MapLabel extends StatelessWidget {
  const _MapLabel({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xE60B0F17),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 8, color: accent),
          const SizedBox(width: 4),
          Text(
            label,
            style: T.body(
              6.4,
              weight: FontWeight.w600,
              color: const Color(0xFFE1E7F3),
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _CityMapPainter extends CustomPainter {
  const _CityMapPainter({required this.driver});

  final bool driver;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0B1019), Color(0xFF090D14)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, background);

    // Water band.
    final water = Path()
      ..moveTo(-10, h * 0.52)
      ..quadraticBezierTo(w * 0.28, h * 0.43, w * 0.53, h * 0.56)
      ..quadraticBezierTo(w * 0.78, h * 0.68, w + 10, h * 0.61)
      ..lineTo(w + 10, h + 10)
      ..lineTo(-10, h + 10)
      ..close();
    canvas.drawPath(water, Paint()..color = const Color(0xFF070D15));
    canvas.drawPath(
      water,
      Paint()
        ..color = const Color(0xFF101927)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );

    // City blocks.
    final blockPaint = Paint()..color = const Color(0xFF0D131E);
    final blockEdge = Paint()
      ..color = const Color(0xFF161F2D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;
    final blocks = <Rect>[
      Rect.fromLTWH(w * 0.06, h * 0.10, w * 0.22, h * 0.10),
      Rect.fromLTWH(w * 0.33, h * 0.08, w * 0.15, h * 0.08),
      Rect.fromLTWH(w * 0.52, h * 0.12, w * 0.18, h * 0.10),
      Rect.fromLTWH(w * 0.76, h * 0.07, w * 0.18, h * 0.12),
      Rect.fromLTWH(w * 0.08, h * 0.26, w * 0.18, h * 0.09),
      Rect.fromLTWH(w * 0.33, h * 0.22, w * 0.12, h * 0.12),
      Rect.fromLTWH(w * 0.53, h * 0.28, w * 0.20, h * 0.10),
      Rect.fromLTWH(w * 0.80, h * 0.27, w * 0.14, h * 0.12),
      Rect.fromLTWH(w * 0.12, h * 0.72, w * 0.20, h * 0.11),
      Rect.fromLTWH(w * 0.43, h * 0.75, w * 0.16, h * 0.08),
      Rect.fromLTWH(w * 0.68, h * 0.70, w * 0.19, h * 0.12),
      Rect.fromLTWH(w * 0.75, h * 0.46, w * 0.13, h * 0.08),
    ];
    for (final rect in blocks) {
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(2));
      canvas.drawRRect(rrect, blockPaint);
      canvas.drawRRect(rrect, blockEdge);
    }

    // Roads.
    final road = Paint()
      ..color = const Color(0xFF161D29)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final thinRoad = Paint()
      ..color = const Color(0xFF121925)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    road.strokeWidth = 2.2;
    canvas.drawLine(Offset(-5, h * 0.40), Offset(w + 5, h * 0.34), road);
    canvas.drawLine(Offset(w * 0.28, -5), Offset(w * 0.42, h + 5), road);
    canvas.drawLine(Offset(w * 0.72, h * 0.20), Offset(w * 0.63, h + 5), road);

    thinRoad.strokeWidth = 1;
    for (final y in [0.18, 0.22, 0.31, 0.62, 0.66, 0.86]) {
      canvas.drawLine(Offset(0, h * y), Offset(w, h * (y - 0.015)), thinRoad);
    }
    for (final x in [0.18, 0.46, 0.58, 0.9]) {
      canvas.drawLine(Offset(w * x, 0), Offset(w * (x - 0.03), h), thinRoad);
    }

    // Route.
    final start = Offset(w * 0.15, h * 0.38);
    final end = Offset(w * 0.84, h * 0.22);
    final route = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(w * 0.30, h * 0.28, w * 0.48, h * 0.36, w * 0.62, h * 0.28)
      ..cubicTo(w * 0.73, h * 0.21, w * 0.77, h * 0.26, end.dx, end.dy);

    final routeShader = LinearGradient(
      colors: driver ? [Brand.ojra, Brand.magenta] : [Brand.cyan, Brand.violet],
    ).createShader(Offset.zero & size);

    canvas.drawPath(
      route,
      Paint()
        ..shader = routeShader
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawPath(
      route,
      Paint()
        ..shader = routeShader
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round,
    );

    // Pickup + drop-off points.
    final accent = driver ? Brand.ojra : Brand.cyan;
    canvas.drawCircle(start, 4, Paint()..color = const Color(0xFF0B0F17));
    canvas.drawCircle(
      start,
      3,
      Paint()
        ..color = Brand.lime
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );
    canvas.drawCircle(
      end,
      5,
      Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    canvas.drawCircle(end, 2.2, Paint()..color = accent);

    // Map annotations.
    _paintLabel(canvas, 'RIVERFRONT', Offset(w * 0.12, h * 0.585), w * 0.082);
    _paintLabel(
      canvas,
      'NORTH DISTRICT',
      Offset(w * 0.58, h * 0.045),
      w * 0.122,
    );
    _paintLabel(canvas, 'DOCK 04', Offset(w * 0.81, h * 0.36), w * 0.065);

    // Faint contour glow near the driver.
    if (driver) {
      const center = Offset(0.63, 0.34);
      final glowCenter = Offset(w * center.dx, h * center.dy);
      final glowRadius = w * 0.28;
      final pulse = Paint()
        ..shader = RadialGradient(
          colors: [
            Brand.ojra.withValues(alpha: 0.18),
            Brand.ojra.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: glowCenter, radius: glowRadius));
      canvas.drawCircle(glowCenter, glowRadius, pulse);
    }
  }

  void _paintLabel(Canvas canvas, String text, Offset offset, double fontSize) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: T.mono(
          math.max(3.6, fontSize * 0.10),
          color: const Color(0xFF4E5C72),
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _CityMapPainter oldDelegate) =>
      oldDelegate.driver != driver;
}

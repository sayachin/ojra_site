import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  static const _steps = <_StepData>[
    _StepData(
      number: '01',
      title: 'Scope',
      description:
          'We pin down the users, the workflows and the constraints. Then we agree on what success looks like before code starts.',
      outputs: ['Product brief', 'Roadmap', 'Architecture'],
    ),
    _StepData(
      number: '02',
      title: 'Design',
      description:
          'Flows, interfaces and a visual system built around your product — not a template. Prototypes make decisions tangible.',
      outputs: ['UX flows', 'UI system', 'Prototype'],
    ),
    _StepData(
      number: '03',
      title: 'Build',
      description:
          'Flutter apps, web front ends and APIs engineered in tight iterations. You see progress in a running product, not a status deck.',
      outputs: ['Apps', 'APIs', 'Admin tools'],
    ),
    _StepData(
      number: '04',
      title: 'Ship & evolve',
      description:
          'We take it through release, store delivery and monitoring — then keep improving what the data reveals.',
      outputs: ['Launch', 'Analytics', 'Support'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SiteBody(
      padding: const EdgeInsets.symmetric(vertical: 104),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(child: _ProcessHeader()),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 900) {
                return _DesktopTimeline(steps: _steps);
              }
              return _MobileTimeline(steps: _steps);
            },
          ),
          const SizedBox(height: 58),
          Reveal(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0D1320), Color(0xFF080B14)],
                ),
                border: Border.all(color: Brand.line),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 620;
                  final message = Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: Brand.signatureSoft,
                          border: Border.all(color: Brand.lineStrong),
                        ),
                        child: const Icon(
                          Icons.timeline_rounded,
                          size: 16,
                          color: Brand.cyan,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A clear scope. A running product. No black boxes.',
                              style: T.body(
                                14,
                                weight: FontWeight.w600,
                                color: Brand.ink,
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'You always know what we’re building, why it matters and what comes next.',
                              style: T.body(
                                12.4,
                                color: Brand.muted,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  if (compact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        message,
                        const SizedBox(height: 16),
                        Text(
                          'ONE TEAM / END TO END',
                          style: T.mono(
                            8,
                            color: Brand.dim,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: message),
                      const SizedBox(width: 16),
                      Text(
                        'ONE TEAM / END TO END',
                        style: T.mono(8, color: Brand.dim, letterSpacing: 1.4),
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

class _ProcessHeader extends StatelessWidget {
  const _ProcessHeader();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width >= 900;
    final titleSize = desktop ? 52.0 : (width < 420 ? 38.0 : 43.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SectionEyebrow('03', 'How we build'),
            const Spacer(),
            if (desktop)
              Text(
                'FOUR STAGES / ONE OWNER',
                style: T.mono(8.5, color: Brand.dim, letterSpacing: 1.6),
              ),
          ],
        ),
        const SizedBox(height: 34),
        if (desktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From first sketch',
                      style: T.display(titleSize, height: 1.05),
                    ),
                    Row(
                      children: [
                        Text('to ', style: T.display(titleSize, height: 1.05)),
                        GradientText(
                          'shipped product.',
                          style: T.display(titleSize, height: 1.05),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 70),
              Expanded(
                flex: 4,
                child: Text(
                  'No handoff maze. You work with the same small team from scope to release — with something real to see at every stage.',
                  style: T.body(15, color: Brand.muted, height: 1.7),
                ),
              ),
            ],
          )
        else ...[
          Text('From first sketch', style: T.display(titleSize, height: 1.05)),
          Row(
            children: [
              Text('to ', style: T.display(titleSize, height: 1.05)),
              Flexible(
                child: GradientText(
                  'shipped product.',
                  style: T.display(titleSize, height: 1.05),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            'No handoff maze. You work with the same small team from scope to release — with something real to see at every stage.',
            style: T.body(14.5, color: Brand.muted, height: 1.7),
          ),
        ],
      ],
    );
  }
}

class _StepData {
  const _StepData({
    required this.number,
    required this.title,
    required this.description,
    required this.outputs,
  });

  final String number;
  final String title;
  final String description;
  final List<String> outputs;
}

class _DesktopTimeline extends StatelessWidget {
  const _DesktopTimeline({required this.steps});

  final List<_StepData> steps;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 6,
          left: 6,
          right: 0,
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Brand.cyan,
                  Brand.violet,
                  Brand.magenta,
                  Color(0x12FFFFFF),
                ],
                stops: [0, 0.42, 0.75, 1],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < steps.length; i++)
              Expanded(
                child: Reveal(
                  delay: Duration(milliseconds: i * 80),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i == steps.length - 1 ? 0 : 34,
                    ),
                    child: _DesktopStep(
                      step: steps[i],
                      last: i == steps.length - 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DesktopStep extends StatefulWidget {
  const _DesktopStep({required this.step, required this.last});

  final _StepData step;
  final bool last;

  @override
  State<_DesktopStep> createState() => _DesktopStepState();
}

class _DesktopStepState extends State<_DesktopStep> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered ? Brand.cyan : Brand.bg,
              border: Border.all(
                color: _hovered ? Brand.cyan : Brand.violet,
                width: 1.2,
              ),
              boxShadow: [
                if (_hovered)
                  BoxShadow(
                    color: Brand.cyan.withValues(alpha: 0.5),
                    blurRadius: 14,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Text(
            widget.step.number,
            style: T.mono(
              9.5,
              color: _hovered ? Brand.cyan : Brand.dim,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.step.title,
            style: T.display(24, weight: FontWeight.w600, height: 1.1),
          ),
          const SizedBox(height: 12),
          Text(
            widget.step.description,
            style: T.body(13, color: Brand.muted, height: 1.65),
          ),
          const SizedBox(height: 20),
          for (final output in widget.step.outputs)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(width: 12, height: 1, color: Brand.lineStrong),
                  const SizedBox(width: 7),
                  Text(
                    output.toUpperCase(),
                    style: T.mono(
                      7.5,
                      color: const Color(0xFF7D8AA1),
                      letterSpacing: 1.0,
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

class _MobileTimeline extends StatelessWidget {
  const _MobileTimeline({required this.steps});

  final List<_StepData> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          Reveal(
            delay: Duration(milliseconds: i * 60),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 24,
                    child: Column(
                      children: [
                        Container(
                          width: 11,
                          height: 11,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Brand.bg,
                            border: Border.all(color: Brand.violet),
                          ),
                        ),
                        if (i < steps.length - 1)
                          Expanded(
                            child: Container(
                              width: 1,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: i < steps.length - 1 ? 34 : 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                steps[i].number,
                                style: T.mono(
                                  9,
                                  color: Brand.cyan,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  steps[i].title,
                                  style: T.display(
                                    24,
                                    weight: FontWeight.w600,
                                    height: 1.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            steps[i].description,
                            style: T.body(13, color: Brand.muted, height: 1.65),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final output in steps[i].outputs)
                                TagChip(output),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

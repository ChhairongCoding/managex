import 'package:flutter/material.dart';

class SkeletonWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const SkeletonWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  State<SkeletonWidget> createState() => _SkeletonWidgetState();
}

class _SkeletonWidgetState extends State<SkeletonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.6).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonWidget(
            height: 180,
            width: double.infinity,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonWidget(height: 20, width: 150),
                const SizedBox(height: 8),
                const SkeletonWidget(height: 16, width: double.infinity),
                const SizedBox(height: 4),
                const SkeletonWidget(height: 16, width: 200),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonWidget(height: 14, width: 100),
                    SkeletonWidget(height: 14, width: 60),
                  ],
                ),
                const SizedBox(height: 8),
                const SkeletonWidget(height: 10, width: double.infinity),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(child: SkeletonWidget(height: 40)),
                    const SizedBox(width: 8),
                    SkeletonWidget(
                      height: 40,
                      width: 40,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    const SizedBox(width: 8),
                    SkeletonWidget(
                      height: 40,
                      width: 40,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InventoryValueSkeleton extends StatelessWidget {
  const InventoryValueSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonWidget(height: 16, width: 120),
          SizedBox(height: 8),
          SkeletonWidget(height: 40, width: 180),
          SizedBox(height: 22),
          SkeletonWidget(height: 30, width: 100, borderRadius: BorderRadius.all(Radius.circular(10))),
        ],
      ),
    );
  }
}

class ListItemSkeleton extends StatelessWidget {
  const ListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonWidget(
            height: 100,
            width: 100,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonWidget(height: 18, width: 150),
                const SizedBox(height: 8),
                const SkeletonWidget(height: 14, width: double.infinity),
                const SizedBox(height: 12),
                const SkeletonWidget(
                  height: 20,
                  width: 80,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ],
            ),
          ),
          const Column(
            children: [
              SkeletonWidget(height: 20, width: 40),
              SizedBox(height: 4),
              SkeletonWidget(height: 12, width: 30),
            ],
          ),
        ],
      ),
    );
  }
}

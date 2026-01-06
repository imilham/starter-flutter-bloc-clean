import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

// TODO: remove-samples-im

class ShimmerSample extends StatelessWidget {
  const ShimmerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader.large('Basic Shapes'),
        const CommonText('Rectangular (Default)').size14px,
        Gap.small8,
        const CommonShimmer(width: double.infinity, height: 100),
        Gap.medium16,
        const CommonText('Circular').size14px,
        Gap.small8,
        const Row(
          children: [
            CommonShimmer.circle(radius: 24),
            Gap.medium16,
            CommonShimmer.circle(radius: 32),
            Gap.medium16,
            CommonShimmer.circle(radius: 40),
          ],
        ),
        const Divider(height: 32),
        const SectionHeader.large('Complex Layouts'),
        const CommonText('List Item Skeleton').size14px,
        Gap.small8,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => Gap.medium16,
          itemBuilder: (_, __) => const _ShimmerListItem(),
        ),
        Gap.large24,
        const CommonText('Card Skeleton').size14px,
        Gap.small8,
        CommonShimmer.content(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
              ),
              Gap.small8,
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(height: 16, width: 200, color: Colors.white),
              ),
              Gap.small8,
              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(height: 12, width: 140, color: Colors.white),
              ),
              Gap.medium16,
            ],
          ),
        ),
      ],
    );
  }
}

class _ShimmerListItem extends StatelessWidget {
  const _ShimmerListItem();

  @override
  Widget build(BuildContext context) {
    return CommonShimmer.content(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Gap.medium16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: double.infinity, color: Colors.white),
                Gap.small8,
                Container(height: 10, width: 150, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';
import '../../utils/app_theme.dart';
import '../../utils/constants.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mode selector tabs
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(
            children: [
              _modeChip(context, 'By District', NewsMode.districtOnly, provider),
              const SizedBox(width: 8),
              _modeChip(context, 'By Category', NewsMode.categoryOnly, provider),
              const SizedBox(width: 8),
              _modeChip(context, 'District + Topic', NewsMode.districtAndTopic, provider),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Conditional filter rows
        if (provider.mode == NewsMode.categoryOnly) ...[
          _sectionLabel('Headlines Category'),
          _horizontalChips(
            items: AppConstants.topHeadlineCategories,
            selected: provider.selectedCategory,
            onSelect: provider.setCategory,
          ),
        ],

        if (provider.mode == NewsMode.districtAndTopic) ...[
          _sectionLabel('Topic Domain'),
          _horizontalChips(
            items: AppConstants.searchTopics,
            selected: provider.selectedTopic,
            onSelect: provider.setTopic,
            showEmoji: true,
          ),
        ],

        // Max results
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          child: Row(
            children: [
              const Text(
                'Max Results:',
                style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              ),
              const SizedBox(width: 8),
              ...[5, 10, 20].map(
                (n) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text('$n'),
                    selected: provider.maxResults == n,
                    onSelected: (_) => provider.setMaxResults(n),
                    selectedColor: AppTheme.accent,
                    labelStyle: TextStyle(
                      color: provider.maxResults == n
                          ? Colors.white
                          : AppTheme.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _modeChip(
    BuildContext context,
    String label,
    NewsMode mode,
    NewsProvider provider,
  ) {
    final isSelected = provider.mode == mode;
    return GestureDetector(
      onTap: () => provider.setMode(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.chipBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : AppTheme.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppTheme.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _horizontalChips({
    required List<Map<String, String>> items,
    required String selected,
    required Function(String) onSelect,
    bool showEmoji = false,
  }) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (_, i) {
          final item = items[i];
          final isSelected = item['id'] == selected;
          return GestureDetector(
            onTap: () => onSelect(item['id']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primary : AppTheme.chipBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppTheme.primary : Colors.grey.shade300,
                ),
              ),
              child: Text(
                showEmoji
                    ? '${item['icon']} ${item['label']}'
                    : '${item['icon']} ${item['label']}',
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : AppTheme.textPrimary,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
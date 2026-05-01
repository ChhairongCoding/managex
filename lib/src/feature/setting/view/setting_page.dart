import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double _lowStockThreshold = 15;
  bool _autoSafetyStock = true;
  bool _pushNotifications = true;
  bool _dailyDigest = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── SHOP PROFILE ──
            _sectionLabel("SHOP PROFILE", theme),
            const SizedBox(height: 12),
            _profileTile(
              theme: theme,
              icon: Icons.storefront_outlined,
              iconColor: theme.colorScheme.primary,
              iconBg: theme.colorScheme.primary.withValues(alpha: 0.1),
              label: "SHOP NAME",
              value: "Central Logistics Hub",
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _profileTile(
              theme: theme,
              icon: Icons.email_outlined,
              iconColor: theme.colorScheme.primary,
              iconBg: theme.colorScheme.primary.withValues(alpha: 0.1),
              label: "PRIMARY CONTACT",
              value: "ops@precisionledger.io",
              onTap: () {},
            ),

            const SizedBox(height: 32),

            // ── INVENTORY PREFERENCES ──
            _sectionLabel("INVENTORY PREFERENCES", theme),
            const SizedBox(height: 12),
            _buildThresholdCard(theme),
            const SizedBox(height: 10),
            _buildToggleTile(
              theme: theme,
              icon: Icons.autorenew_rounded,
              title: "Auto-calculate Safety Stock",
              value: _autoSafetyStock,
              onChanged: (v) => setState(() => _autoSafetyStock = v),
            ),

            const SizedBox(height: 32),

            // ── COMMUNICATION ──
            _sectionLabel("COMMUNICATION", theme),
            const SizedBox(height: 12),
            _buildToggleTile(
              theme: theme,
              icon: Icons.notifications_outlined,
              iconColor: theme.colorScheme.primary,
              iconBg: theme.colorScheme.primary.withValues(alpha: 0.1),
              title: "Push Notifications",
              subtitle: "Alerts for depletion & restocks",
              value: _pushNotifications,
              onChanged: (v) => setState(() => _pushNotifications = v),
            ),
            const SizedBox(height: 10),
            _buildToggleTile(
              theme: theme,
              icon: Icons.mark_email_read_outlined,
              iconColor: theme.colorScheme.primary,
              iconBg: theme.colorScheme.primary.withValues(alpha: 0.1),
              title: "Daily Digest",
              subtitle: "End-of-day stock summary via email",
              value: _dailyDigest,
              onChanged: (v) => setState(() => _dailyDigest = v),
            ),

            const SizedBox(height: 32),

            // ── HELP & SUPPORT ──
            _sectionLabel("HELP & SUPPORT", theme),
            const SizedBox(height: 12),
            _supportTile(
              theme: theme,
              icon: Icons.menu_book_outlined,
              iconColor: theme.colorScheme.primary,
              iconBg: theme.colorScheme.primary.withValues(alpha: 0.1),
              title: "Knowledge Base",
              subtitle: "Guides & tutorials",
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _supportTile(
              theme: theme,
              icon: Icons.support_agent_outlined,
              iconColor: const Color(0xFF388E3C),
              iconBg: const Color(0xFFE8F5E9),
              title: "Direct Support",
              subtitle: "Chat with an expert",
              onTap: () {},
            ),

            const SizedBox(height: 40),

            // ── SIGN OUT ──
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(
                    color: theme.colorScheme.error.withValues(alpha: 0.3),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: const Text(
                  "Sign Out from Ledger",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ── Section Label ──
  Widget _sectionLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.labelSmall?.copyWith(
        color: Colors.grey[500],
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }

  // ── Profile Tile (Shop Name / Contact) ──
  Widget _profileTile({
    required ThemeData theme,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  // ── Threshold Slider Card ──
  Widget _buildThresholdCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Global Low Stock\nThreshold",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Default alert level for all SKUs",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${_lowStockThreshold.round()}%",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: theme.colorScheme.primary,
              inactiveTrackColor: theme.colorScheme.primary.withValues(
                alpha: 0.12,
              ),
              thumbColor: theme.colorScheme.primary,
              overlayColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: _lowStockThreshold,
              min: 0,
              max: 100,
              onChanged: (v) => setState(() => _lowStockThreshold = v),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0%",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "50%",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "100%",
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Toggle Tile (Notifications, Digest, Safety Stock) ──
  Widget _buildToggleTile({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? subtitle,
    Color? iconColor,
    Color? iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg ?? Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor ?? theme.colorScheme.onSurface,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  // ── Support Tile (Knowledge Base, Direct Support) ──
  Widget _supportTile({
    required ThemeData theme,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

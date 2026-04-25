import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchBar(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: List.generate(
                  6,
                  (index) => Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: theme.colorScheme.primary),
                    ),
                    child: Center(
                      child: Text(
                        "All Stock",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  SearchBar searchBar() {
    return SearchBar(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
      elevation: WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(Color(0xffE7E7F2)),
      hintText: "Search",
      hintStyle: WidgetStatePropertyAll(
        TextStyle(color: Colors.blueGrey.shade400),
      ),
      leading: Icon(Icons.search, color: Colors.blueGrey.shade400),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/opportunity.dart';
import '../widgets/category_filter.dart';
import '../widgets/featured_card.dart';
import '../widgets/opportunity_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<<FeedScreen> with SingleTickerProviderStateMixin {
  String selectedCategory = 'All';
  late TabController _tabController;
  int _selectedIndex = 0;

  List<<Opportunity> get filteredOpportunities {
    if (selectedCategory == 'All') return MockData.opportunities;
    return MockData.opportunities
        .where((o) => o.category.toLowerCase() == selectedCategory.toLowerCase())
        .toList();
  }

  List<<Opportunity> get featuredOpportunities {
    return MockData.opportunities.where((o) => o.isFeatured).toList();
  }

  List<<Opportunity> get trendingOpportunities {
    return MockData.opportunities.where((o) => o.isTrending).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'ShikALU',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6C63FF),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Feed',
                                style: TextStyle(
                                  color: Color(0xFF6C63FF),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.notifications_outlined, color: Color(0xFF6C63FF)),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[400]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Find your next move...',
                            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.tune, color: Color(0xFF6C63FF), size: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Category Filter
            SliverToBoxAdapter(
              child: CategoryFilter(
                categories: MockData.categories,
                selectedCategory: selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // Featured Section
            if (selectedCategory == 'All') ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured Events',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 240,
                  child: PageView.builder(
                    itemCount: featuredOpportunities.length,
                    controller: PageController(viewportFraction: 0.92),
                    itemBuilder: (context, index) {
                      return FeaturedCard(
                        opportunity: featuredOpportunities[index],
                        onTap: () => _showEventDetails(featuredOpportunities[index]),
                      );
                    },
                  ),
                ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],

            // All Opportunities Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCategory == 'All' ? 'All Opportunities' : '$selectedCategory Events',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${filteredOpportunities.length} events',
                        style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // Opportunities List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final opportunity = filteredOpportunities[index];
                  return OpportunityCard(
                    opportunity: opportunity,
                    onTap: () => _showEventDetails(opportunity),
                  );
                },
                childCount: filteredOpportunities.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
      
      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_rounded, 'Feed', 0),
                _buildNavItem(Icons.explore_outlined, 'Discover', 1),
                _buildNavItem(Icons.people_outline, 'Communities', 2),
                _buildNavItem(Icons.notifications_outlined, 'Alerts', 3),
                _buildNavItem(Icons.person_outline, 'Profile', 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF6C63FF) : Colors.grey[400],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF6C63FF) : Colors.grey[400],
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(Opportunity opportunity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(0),
            children: [
              // Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Event Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    opportunity.imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Category & Type
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        opportunity.category.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        opportunity.type,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  opportunity.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Organizer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(opportunity.organizerImage),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opportunity.organizerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Organizer',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Follow',
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Details Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow(Icons.calendar_today, 'Date', '${opportunity.formattedDate}, ${opportunity.timeRange}'),
                      const Divider(height: 24),
                      _buildDetailRow(Icons.location_on, 'Location', opportunity.location),
                      if (opportunity.prizePool != null) ...[
                        const Divider(height: 24),
                        _buildDetailRow(Icons.emoji_events, 'Prize Pool', opportunity.prizePool!),
                      ],
                      const Divider(height: 24),
                      _buildDetailRow(Icons.people, 'Attendees', '${opportunity.attendeesCount} / ${opportunity.maxAttendees}'),
                      const Divider(height: 24),
                      _buildDetailRow(Icons.confirmation_number, 'Entry', opportunity.isFree ? 'Free' : opportunity.entryFee!),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'About the Event',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  opportunity.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Tags
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: opportunity.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // RSVP Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You\'ve RSVP\'d to ${opportunity.title}!'),
                          backgroundColor: const Color(0xFF6C63FF),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'RSVP Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF6C63FF), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
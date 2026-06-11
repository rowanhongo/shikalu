// RSVP SCREEN 
// This screen handles event registration
// Features: RSVP, Cancel RSVP, attendee count

import 'package:flutter/material.dart';
import 'event_model.dart';
import 'my_events_screen.dart';

class RsvpScreen extends StatefulWidget {
  final Event event;

  const RsvpScreen({super.key, required this.event});

  @override
  State<RsvpScreen> createState() => _RsvpScreenState();
}

class _RsvpScreenState extends State<RsvpScreen> {

  // Tracks if the organizer is followed
  bool _isFollowing = false;

  // Handles RSVP and cancel RSVP
  void _handleRsvp() {
    setState(() {
      if (widget.event.isRsvped) {
        widget.event.isRsvped = false;
        widget.event.attendeeCount--;
      } else {
        widget.event.isRsvped = true;
        widget.event.attendeeCount++;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.event.isRsvped
              ? '✅ You are registered for ${widget.event.title}!'
              : '❌ RSVP cancelled for ${widget.event.title}',
        ),
        backgroundColor: widget.event.isRsvped
            ? const Color(0xFFB5321A)
            : Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Handles follow/unfollow organizer
  void _handleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Share button
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
          // Favourite button
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          // My Events button
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyEventsScreen(events: mockEvents),
                ),
              );
            },
            icon: const Icon(Icons.bookmark, color: Color(0xFFB5321A)),
            label: const Text(
              'My Events',
              style: TextStyle(color: Color(0xFFB5321A)),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Category tags row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _categoryTag(widget.event.category, const Color(0xFFB5321A)),
                  const SizedBox(width: 8),
                  _categoryTag('Innovation', Colors.teal),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Event Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.event.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Organized by + Follow button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    // Organizer icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB5321A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.group,
                        color: Color(0xFFB5321A),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Organizer name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Organized by',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.event.organizer,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB5321A),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Follow button - changes when tapped
                    GestureDetector(
                      onTap: _handleFollow,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _isFollowing
                              ? Colors.grey.shade200
                              : const Color(0xFFB5321A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _isFollowing ? 'Following' : 'Follow',
                          style: TextStyle(
                            color: _isFollowing
                                ? Colors.black54
                                : Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Date, Time, Location details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _detailRow(Icons.calendar_today, widget.event.date),
                  _detailRow(Icons.access_time, widget.event.time),
                  _detailRow(Icons.location_on, widget.event.location),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Attendee count + avatars
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Stacked avatar circles (mock)
                  SizedBox(
                    width: 80,
                    height: 32,
                    child: Stack(
                      children: [
                        _avatar(0, Colors.orange),
                        _avatar(20, Colors.blue),
                        _avatar(40, Colors.green),
                        _avatar(60, Colors.purple),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+${widget.event.attendeeCount} attending',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB5321A),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Divider(thickness: 1),

            // About the Event
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'About the Event',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.event.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Divider(thickness: 1),

            // =====================
            // LIVE DISCUSSION SECTION
            // TODO: Rowan's chat widget goes here
            // =====================

            const SizedBox(height: 80),
          ],
        ),
      ),

      // RSVP button at bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _handleRsvp,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.event.isRsvped
                ? Colors.grey
                : const Color(0xFFB5321A),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            widget.event.isRsvped
                ? '✓ Registered - Tap to Cancel'
                : 'Register Now',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Category tag widget
  Widget _categoryTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Detail row widget (date, time, location)
  Widget _detailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Single avatar circle
  Widget _avatar(double left, Color color) {
    return Positioned(
      left: left,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.person, size: 16, color: Colors.white),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'event_model.dart';
import 'rsvp_screen.dart';

// This screen shows all events the student has RSVPed for
// It's a StatelessWidget because it just displays data, no changes here

class MyEventsScreen extends StatelessWidget {
  final List<Event> events; // Receives the full events list

  const MyEventsScreen({super.key, required this.events});

  @override
  Widget build(BuildContext context) {

    // Filter - only show events where isRsvped is true
    final myEvents = events.where((e) => e.isRsvped).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Events',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: myEvents.isEmpty
          // Empty state - shown when no events are registered
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No events yet!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'RSVP to events to see them here',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          // Show list of registered events
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myEvents.length,
              itemBuilder: (context, index) {
                final event = myEvents[index];
                return _eventCard(context, event);
              },
            ),
    );
  }

  // Event card widget for each registered event
  Widget _eventCard(BuildContext context, Event event) {
    return GestureDetector(
      // Tap the card to go back to event detail
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RsvpScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Red left border accent
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFB5321A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category tag
                  Text(
                    event.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFB5321A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Event title
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Date and attendee count
                  Text(
                    '${event.date} • ${event.attendeeCount} attending',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Registered checkmark badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFB5321A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '✓ Going',
                style: TextStyle(
                  color: Color(0xFFB5321A),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
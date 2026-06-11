// Defines the Event data structure
// Contains mock ALU events for testing

class Event {
  final String id;           
  final String title;        
  final String category;     
  final String date;         
  final String time;         
  final String location;    
  final String description;  
  final String organizer;    
  int attendeeCount;         
  bool isRsvped;             

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.organizer,
    required this.attendeeCount,
    this.isRsvped = false,   // Default is false cause its not registered yet
  });
}

// our mock data 
// Based on ALU events
List<Event> mockEvents = [
  Event(
    id: '1',
    title: 'CBC End of Spring Hackathon',
    category: 'Hackathon',
    date: 'May 25-28, 2026',
    time: '9:00 AM',
    location: 'Kenya-Burundi ,Enterprise Commons-ALU Kigali',
    description: 'Build something that matters. Theme: AI for Social Impact. Tracks include Biology & Health, Economic Empowerment, Governance, and more. Prizes include USD 1,500 in API credits.',
    organizer: 'Claude Builder Club',
    attendeeCount: 41,
  ),
  Event(
    id: '2',
    title: 'Spirit and Life Conference',
    category: 'Social',
    date: 'June 19-20, 2026',
    time: '4:00 PM',
    location: 'African Leadership University, Kigali',
    description: 'Transforming Generation Conference 4.0. Theme: Spirit and Life, John 6:63. Featuring Minister Kaestrings and Apostle Tolu Agboola.',
    organizer: 'ALU Christian Fellowship',
    attendeeCount: 67,
  ),
  Event(
    id: '3',
    title: 'Design Thinking Sprint',
    category: 'Workshop',
    date: 'Tomorrow, 10:00 AM',
    time: '10:00 AM',
    location: 'ALU Innovation Lab',
    description: 'A hands on workshop to learn design thinking methodology and apply it to real ALU community challenges.',
    organizer: 'ALU Entrepreneurship Club',
    attendeeCount: 28,
  ),
  Event(
    id: '4',
    title: 'CV & Portfolio Review',
    category: 'Career',
    date: 'Nov 03, 11:00 AM',
    time: '11:00 AM',
    location: 'ALU Career Center',
    description: 'Get your CV and portfolio reviewed by industry professionals. Limited slots available.',
    organizer: 'ALU Career Services',
    attendeeCount: 45,
  ),
];

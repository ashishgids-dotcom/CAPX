import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_theme.dart';

/// Consultation slot picker.
///
/// This uses `table_calendar` for the in-app date grid. To go live:
///  1. Replace `_availableSlotsFor()` with a real Calendly (or your own
///     backend) API call to fetch actually-available 30-min slots.
///  2. On booking, call your backend, which should call the Calendly API
///     (or your scheduling backend) server-side, generate a real Zoom/Meet
///     link via webhook, and store the booking.
///  3. Replace the WhatsApp deep link body below with the real meeting link
///     returned by that backend call instead of a placeholder.
class ConsultationSchedulerWidget extends StatefulWidget {
  const ConsultationSchedulerWidget({super.key});

  @override
  State<ConsultationSchedulerWidget> createState() =>
      _ConsultationSchedulerWidgetState();
}

class _ConsultationSchedulerWidgetState extends State<ConsultationSchedulerWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedSlot;

  List<String> _availableSlotsFor(DateTime day) {
    // Placeholder fixed slots — swap for a real Calendly availability call.
    return const ['10:00 AM', '11:30 AM', '2:00 PM', '4:30 PM', '6:00 PM'];
  }

  Future<void> _confirmBooking(BuildContext context) async {
    if (_selectedDay == null || _selectedSlot == null) return;

    final dateStr = '${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}';
    // Placeholder meeting link — replace with the real Zoom/Meet URL your
    // backend generates via the Calendly webhook after booking succeeds.
    const placeholderMeetingLink = 'https://meet.example.com/your-real-link';

    final message = Uri.encodeComponent(
      'Your 1-on-1 expert consultation is booked for $dateStr at $_selectedSlot.\n'
      'Join link: $placeholderMeetingLink',
    );
    final uri = Uri.parse('https://wa.me/?text=$message');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open WhatsApp on this device.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final slots = _selectedDay != null ? _availableSlotsFor(_selectedDay!) : <String>[];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('Book your 30-min Expert Consultation',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.5)),
            ),
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 60)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                  _selectedSlot = null;
                });
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColors.royalBlue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.emeraldGreen,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(formatButtonVisible: false),
            ),
            if (slots.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: slots.map((s) {
                  final isSelected = s == _selectedSlot;
                  return ChoiceChip(
                    label: Text(s),
                    selected: isSelected,
                    selectedColor: AppColors.emeraldGreen,
                    labelStyle: TextStyle(color: isSelected ? Colors.white : null),
                    onSelected: (_) => setState(() => _selectedSlot = s),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.chat_rounded),
                  label: const Text('Confirm & Send Link via WhatsApp'),
                  onPressed: _selectedSlot == null ? null : () => _confirmBooking(context),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

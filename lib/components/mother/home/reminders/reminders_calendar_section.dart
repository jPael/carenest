import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RemindersCalendarSection extends StatefulWidget {
  const RemindersCalendarSection({super.key});

  @override
  State<RemindersCalendarSection> createState() => _RemindersCalendarSectionState();
}

class _RemindersCalendarSectionState extends State<RemindersCalendarSection> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8 * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Start date and time", style: TextStyle(fontSize: 8 * 2)),
                DropdownButton<String>(
                  value: "January",
                  items: ["January", "February", "March"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            TableCalendar(
              focusedDay: _selectedDay,
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              calendarFormat: CalendarFormat.week,
              headerVisible: false,
              daysOfWeekHeight: 30,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) {
                  return Center(
                    child: Text(date.day.toString(),
                        style: const TextStyle(fontSize: 16, color: Colors.black)),
                  );
                },
                todayBuilder: (context, date, _) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8 * 2, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${date.day}",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                todayDecoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green.shade600,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

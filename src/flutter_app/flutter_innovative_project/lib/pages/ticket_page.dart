import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/repositories/ticket_repository.dart';
import '../models/ticket.dart';

class TicketPage extends StatefulWidget {
  final int eventId;
  const TicketPage({super.key, required this.eventId});
  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  TicketRepository ticketRepository = TicketRepository();

  @override
  Widget build(BuildContext context) {
    List<Ticket> tickets = ticketRepository.getTicketsByEvent(widget.eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Tickets'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          Ticket ticket = tickets[index];
          return ListTile(
            title: Text(ticket.name),
            subtitle: Text('Price: \$${ticket.price.toStringAsFixed(2)}'),
            trailing: Text('Available: ${ticket.amount}'),
          );
        },
      ),
    );
  }
}
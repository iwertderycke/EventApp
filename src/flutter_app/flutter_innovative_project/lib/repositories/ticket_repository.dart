// ignore_for_file: file_names

import '../models/ticket.dart';

class TicketRepository {
  List<Ticket> ticketList = [
    Ticket(id: 1, name: 'Kompass raver', amount: 5000, price: 20, eventId: 4),
    Ticket(id: 2, name: 'Kompass raver', amount: 5000, price: 20, eventId: 5),
    Ticket(id: 3, name: 'Early bird', amount: 100, price: 7, eventId: 1),
    Ticket(id: 4, name: 'Regular ticket', amount: 700, price: 10, eventId: 1),
  ];

  List<Ticket> getTickets() {
    return ticketList.toList();
  }

  List<Ticket> getTicketsByEvent(int eventId) {
    return ticketList.where((ticket) => ticket.eventId == eventId).toList();
  }

  Ticket? getTicketById(int id) {
    return ticketList.firstWhere((ticket) => ticket.id == id);
  }
}
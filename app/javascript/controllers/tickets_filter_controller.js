import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tickets-filter"
export default class extends Controller {
  static targets = ["tableRow"];
  connect() {
    console.log("ticket controller connected")
  }

  filterTickets(event) {
    const status = event.target.getAttribute("data-status");

    this.tableRowTargets.forEach((row) => {
      const ticketStatus = row.getAttribute("data-status");

      if (status === "all") {
        row.style.display = "table-row";
      } else {
        row.style.display = ticketStatus === status ? "table-row" : "none";
      }
    });
  }
}

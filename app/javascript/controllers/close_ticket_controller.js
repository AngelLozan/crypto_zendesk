import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="close-ticket"
export default class extends Controller {
  connect() {
    console.log("close ticket connected")
  }

  closeTicket(event) {
    const button = event.target;
    button.disabled = true;
    button.textContent = "Closed";
  }
}

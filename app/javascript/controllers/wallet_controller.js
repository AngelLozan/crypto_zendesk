import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="wallet"
export default class extends Controller {
  static targets = [ "modal" ]

  connect() {
    console.log("Hello, Stimulus!");
  }

  open(e) {
    console.log("open")
    e.preventDefault();
    this.modalTarget.classList.remove('d-none');
    // document.body.classList.add('modal-open');
  }

  close(e) {
    console.group('close')
    e.preventDefault();
    if (e.target !== this.modalTarget) {
      this.modalTarget.classList.add('d-none');
    }
  }

}

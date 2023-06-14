import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="wallet"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!");
  }

  
}

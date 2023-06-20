import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {

  connect() {
    console.log("hello")
  }

  static values = {
    icon: String,
    alertTitle: String,
    alertHtml: String,
    confirmButtonText: String,
    showCancelButton: Boolean,
    cancelButtonText: String
  }

  initSweetalert(event) {
    event.preventDefault(); // Prevent the form to be submited after the submit button has been clicked

    Swal.fire({
      position: 'center',
      icon: 'success',
      title: 'Your ticket has been submited! You will be redirected to a LiveChat with support',
      showConfirmButton: true,
      confirmButtonText: 'Ok',
    }).then((action) => {
      event.target[event.type](); // "submit"
    })
  }
}

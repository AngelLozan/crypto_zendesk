import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {

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

    // fetch request to tickets create
    // if the response has errors, add the errors to the html
    // if it does not, display swal
    // after click on "ok" on the swal button, redirect to chatroom show

    Swal.fire({
      position: 'center',
      icon: 'success',
      title: 'Your ticket has been submited! You will be redirected to a LiveChat with support',
      showConfirmButton: true,
      confirmButtonText: 'Ok',
      inputValidator: (value) => {
        if (!value) return 'Your text here'
        else return null
      }
    }).then((action) => {
      event.target[event.type](); // "submit"
    })
}
}

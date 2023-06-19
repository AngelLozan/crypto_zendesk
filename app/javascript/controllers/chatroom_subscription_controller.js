import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages", "form"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data)}
    )
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
  }
  #insertMessageAndScrollDown(data) {
    this.element.insertAdjacentHTML("beforeend", data)
    this.element.scrollTo(0, this.element.scrollHeight)
  }


  submitForm(e) {
    e.preventDefault();
    // console.log(e.currentTarget);
    try {
      console.log("triggering form submit event");
      this.formTarget.submit();
    } catch (error) {
      console.log(error.message);
    }

  }
}

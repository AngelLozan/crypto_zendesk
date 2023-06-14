import { Controller } from "@hotwired/stimulus";
// import { Modal } from "bootstrap"

// Connects to data-controller="wallet"
export default class extends Controller {
  static targets = ["modal", "buttonClose", "overlay", "buttonOpen", "address"];

  solanaProvider;

  async connect() {
    console.log("Hello, Stimulus!");
    this.solanaProvider = this.getSolanaProvider();
    console.log(this.solanaProvider);
  }

  openModal() {
    this.modalTarget.classList.remove("hidden");
    this.overlayTarget.classList.remove("hidden");
  }

  closeModal() {
    this.modalTarget.classList.add("hidden");
    this.overlayTarget.classList.add("hidden");
  }

  async phantomConnect() {
    try {
      // const resp = await this.solanaProvider.connect();
      const resp = await window.phantom.solana.connect()
      console.log(resp.publicKey.toString());
      this.addressTarget.value = await resp.publicKey.toString();
      this.closeModal();
    } catch (err) {
      console.log(err.message);
    }
  }

  async getSolanaProvider() {
    if ("phantom" in window) {
      const provider = await window.phantom?.solana;

      if (provider?.isPhantom) {
        return provider;
      }
    }
    window.open("https://phantom.app/", "_blank");
  }
}

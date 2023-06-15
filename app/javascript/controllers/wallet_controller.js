import { Controller } from "@hotwired/stimulus";
import { Web3ModalAuth } from '@web3modal/auth-html'

// Connects to data-controller="wallet"
export default class extends Controller {
  static targets = ["modal", "buttonClose", "overlay", "buttonOpen", "address"];
  static values = {
    projectId: String,
  };

  solanaProvider;
  web3Modal;

  async connect() {
    console.log("Hello, Stimulus!");
    console.log(this.projectIdValue);
    this.solanaProvider = await this.getSolanaProvider();
    this.web3Modal = await this.getWalletConnect();
    console.log(this.solanaProvider);
    console.log(this.web3Modal);
  }

  openModal() {
    this.modalTarget.classList.remove("hidden");
    this.overlayTarget.classList.remove("hidden");
  }

  closeModal() {
    this.modalTarget.classList.add("hidden");
    this.overlayTarget.classList.add("hidden");
  }

  async walletConnect() {
    try {
      const data = await this.web3Modal.signIn({ statement: 'Connect to Web3Modal' })
      console.info(data)
      this.closeModal();
    } catch (err) {
      console.log(err.message);
    }
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

  async getWalletConnect() {
    const web3Modal = await new Web3ModalAuth({
      projectId: this.projectIdValue,
      metadata: {
        name: 'Web3Modal',
        description: 'Web3Modal',
        url: 'web3modal.com',
        icons: ['https://walletconnect.com/_next/static/media/logo_mark.84dd8525.svg']
      }
    })
    return web3Modal;
  }

  async getSolanaProvider() {
    if ("phantom" in window) {
      const provider = await window.phantom?.solana;

      if (provider?.isPhantom) {
        return provider;
      }
    }
    // window.open("https://phantom.app/", "_blank");
  }
}

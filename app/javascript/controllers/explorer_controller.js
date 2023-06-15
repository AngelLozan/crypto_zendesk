import { Controller } from "@hotwired/stimulus"
import validateSolAddress from "./solana.js";
import validateSignature from "./solSignature.js";
import getAlgoData from './algoTx.js';
import moneroText from './moneroText.js';
import lookUpText from './lookUpText.js';
//import verifyTezTx from './tezTx.js'; //@dev Not neccessary at the moment.


// Connects to data-controller="explorer"
export default class extends Controller {
  static targets = [ "sourceInput", "snackbar"]

  connect() {
    console.log("explorer stimulus controller connected");
  }

  emojis = [
    "✌️ Enter query",
    "🤔 I'm listening",
    "🦾 I find things",
    "🚀 To the moon!",
    "🤙 Query vibez",
    "🖖 Search ser",
    "👋 Hi there",
    "👾 Can I help?",
    "🧠 Query me",
    "🌈 Enter search",
    "✨ Shiny searches",
    "💫 Find a tx here",
];
getRandomEmoji () {
    return this.emojis[~~(Math.random() * this.emojis.length)];
};

async openTab (_url) {
  await window.open( _url, "_blank");
}

async search(e) {
    e.preventDefault();
    let inputValue = await this.sourceInputTarget.value;

    let source = await inputValue.trim();

    console.log(source.length);

    if (source === null || source === undefined || !source) {
        this.snackbarTarget.innerText = `${getRandomEmoji()}`;
        this.snackbarTarget.className = "show";
        setTimeout(function() {
            this.snackbarTarget.className = this.snackbarTarget.className.replace("show", "");
        }, 800);
    } else if (/^\s*[0-9a-z\sA-Z]{3,9}\s*$/gi.test(source)) {
        //@dev Match asset ticker or crypto name search to populate iframe.
        let noSpaceSource = await source.replace(/\s/g,'');
        let url = 'https://coinranking.com/?search=' + noSpaceSource;
        await this.openTab(url);
    } else if (/^tz[a-z0-9]{34}$|^o[a-z0-9]{50}$/gi.test(source)) {
        //@dev Tezos address or transaction respectively.
        let url = 'https://tzstats.com/' + source;
        await this.openTab(url);
    } else if (/^[A-Z2-7]{58}$/g.test(source)) {
        //@dev Placeholder for Algo address
        let url = 'https://algoexplorer.io/address/' + source;
        await this.openTab(url);
    } else if (await getAlgoData(source) && source.length === 52) {
        //@dev Placeholder for Algo TX. Regex -> /^[A-Z2-7]{52}$/g.test(source)
        let url = 'https://algoexplorer.io/tx/' + source;
        await this.openTab(url);
    } else if (/^0x[a-fA-F0-9]{40}$/g.test(source)) {
        //@dev EVM address
        let url = 'https://debank.com/profile/' + source;
        await this.openTab(url);
    } else if (/^0x([A-Fa-f0-9]{64})$/g.test(source)) {
        //@dev EVM transaction
        let url = 'https://blockscan.com/tx/' + source;
        await this.openTab(url);
    } else if (/^r[1-9A-HJ-NP-Za-km-z]{25,33}$/g.test(source)) {
        //@dev XRP address
        let url = 'https://xrpscan.com/account/' + source;
        await this.openTab(url);
    } else if ((await validateSolAddress(source)) === true) {
        //@dev SOL address
        let url = 'https://solscan.io/account/' + source;
        await this.openTab(url);
    } else if (await validateSignature(source)) {
        //@dev SOL TX
        let url = 'https://solscan.io/tx/' + source;
        await this.openTab(url);
    } else if (/^(cosmos)[a-z0-9]{39}$/g.test(source)) {
        //@dev Atom Address
        let url = 'https://atomscan.com/accounts/' + source;
        await this.openTab(url);
    } else if (/^(bnb1)[a-z0-9]{38}$/g.test(source)) {
        //@dev BNB Beacon Address
        let url = 'https://binance.mintscan.io/account/' + source;
        await this.openTab(url);
    } else if (/^T[A-Za-z1-9]{33}$/g.test(source)) {
        //@dev TRX address
        let url = 'https://tronscan.org/#/address/' + source;
        await this.openTab(url);
    } else if (
        /^(0|(?:[1-9]\d*))\.(0|(?:[1-9]\d*))\.(0|(?:[1-9]\d*))(?:-([a-z]{5}))?$/.test(
            source
        )
    ) {
        //@dev HBAR address
        let url = 'https://hashscan.io/#/mainnet/account/' + source;
        await this.openTab(url);
    } else if (
        /^(0|(?:[1-9]\d*))\.(0|(?:[1-9]\d*))\.(0|(?:[1-9]\d*))(?:-([a-z]{5}))?@?/.test(
            source
        )
    ) {
        //@dev HBAR TXID
        const hbarID = source.replace(/[^a-zA-Z0-9]/g, "");
        let url = 'https://hashscan.io/#/mainnet/transaction/' + hbarID;
        await this.openTab(url);
    } else if (/4[0-9AB][1-9A-HJ-NP-Za-km-z]{93}$/g.test(source)) {
        //@dev Monero Address identify and warn it's not viewable on blockchain.
        await moneroText(source);
    } else if (
        /^[1-9A-HJ-NP-Za-km-z]{59}$|^(addr1)[a-z0-9]+/g.test(source)
    ) {
        //@dev Ada addresses
        let url = 'https://cardanoscan.io/address/' + source;
        await this.openTab(url);
    } else if (/^(terra1)[a-z0-9A-Z]{38}$/g.test(source)) {
        //@dev LUNC address.
        let url = 'https://finder.terra.money/classic/address/' + source;
        await this.openTab(url);
    } else if (
        /^grs[a-zA-Z0-9]{5,88}$|^F[a-km-zA-HJ-NP-Z1-9]{26,33}$|^G[A-Z0-9]{55}$|^ltc[a-zA-Z0-9]{5,88}$|^[LM][a-km-zA-HJ-NP-Z1-9]{26,33}$|^[7X][a-km-zA-HJ-NP-Z1-9]{26,33}$|^[9AD][a-km-zA-HJ-NP-Z1-9]{26,33}$|^([qp][qpzry9x8gf2tvdw0s3jn54khce6mua7l]{40,120}|(bitcoincash)?[qp][qpzry9x8gf2tvdw0s3jn54khce6mua7l]{40,120})$|^bc(0([ac-hj-np-z02-9]{39}|[ac-hj-np-z02-9]{59})|1[ac-hj-np-z02-9]{8,87})$|^1[a-km-zA-HJ-NP-Z1-9]{25,34}(?!\/)$|^3[a-km-zA-HJ-NP-Z1-9]{25,34}$/g.test(
            source
        )
    ) {
        //@dev Most chains addresses. Needs to stay last so other regex's work. Includes LTC, XLM, DASH, DOGE, XMR, BCH and BTC derivations.
        let url = 'https://blockchair.com/search?q=' + source;
        await this.openTab(url);
    } else if (/^\s*[0-9a-fA-F]{64}\s*$/g.test(source)) {
        //@dev Transaction Window for Multiple chains (So far: Tron, ATOM, UTXOs, BNB beacon chain, XRP, ADA, LUNC)
        let noSpaceSourceM = await source.replace(/\s/g,'');
        lookUpText(noSpaceSourceM);
    } else {
        console.log("No match found.");
    }
};

}

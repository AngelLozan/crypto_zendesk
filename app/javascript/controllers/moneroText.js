const moneroText = async (source) => {
  var snackbar = await document.getElementById("snackbar");
  snackbar.innerText =
      "This looks like a Monero address, which you cannot view on an explorer usually 🔍 Click this dialogue to open a new tab anyways.";
  snackbar.className = "showMulti";
  snackbar.style.right = "15px";

  snackbar.addEventListener(
      "click",
      function(event) {
          let URL = "https://localmonero.co/blocks/search/" + source;
          chrome.tabs.create({ active: true, url: URL });

      }, { once: true }
  );
}

export default moneroText;

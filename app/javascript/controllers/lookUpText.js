const lookUpText = async (source) => {
  var snackbar = await document.getElementById("snackbar");
  snackbar.innerText =
      "This could be a few chains 🔍 Click this dialogue to open a new window for multiple ⛓ explorers. Or click me to reset.";
  snackbar.className = "showMulti";
  snackbar.style.right = "15px";

  snackbar.addEventListener(
      "click",
      function(event) {
          let urlArray = [
              "https://blockchair.com/search?q=" + source,
              "https://tronscan.org/#/transaction/" + source,
              "https://binance.mintscan.io/txs/" + source,
              "https://atomscan.com/transactions/" + source,
              "https://xrpscan.com/tx/" + source,
              "https://cardanoscan.io/transaction/" + source,
              "https://finder.terra.money/classic/tx/" + source,
          ];
          chrome.windows.create({
              focused: false,
              state: "minimized",
              url: urlArray,
          });
          snackbar.innerText = "I opened a new, minimized window 👀";
          snackbar.className = snackbar.className.replace(
              "showMulti",
              "show"
          );
          snackbar.style.right = "40%";
          setTimeout(function() {
              snackbar.className = snackbar.className.replace("show", "");
              snackbar.style.right = snackbar.style.right.replace(
                  "40%",
                  "60%"
              );
          }, 1500);
      }, { once: true }
  );
};

export default lookUpText;

//@dev CSP allows CORs self source. Sometimes this matches non-tx strings and produces valid response. Edge case.
import axios from 'axios';

const getAlgoData = async (source) => {
  let api = 'https://mainnet-idx.algonode.network/v2/transactions/';
  let tx = source;

  try {
    const response = await axios.get(`${api}${tx}`, {
      headers: {
        accept: 'application/json',
      },
    });

    if (response.status === 200) {
      console.log("status: ", response.status);
      return true;
    }
  } catch (err) {
    if (err.response && err.response.status === 404) {
      console.log("Transaction not found.");
      // Handle the 404 error here
    } else {
      console.log("Error in Algo tx: ", err);
      // Handle other errors
    }
  }
};

export default getAlgoData;

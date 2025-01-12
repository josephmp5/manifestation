const axios = require("axios");
const functions = require("firebase-functions");

const OPENAI_API_KEY = "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";

exports.generateResponse = functions.https.onRequest(async (req, res) => {
  try {
    const { prompt } = req.body;

    const response = await axios.post(
      "https://api.openai.com/v1/completions",
      {
        prompt,
      },
      {
        headers: {
          Authorization: `Bearer ${OPENAI_API_KEY}`,
        },
      }
    );

    res.json(response.data);
  } catch (error) {
    res.status(500).send(error.message);
  }
});

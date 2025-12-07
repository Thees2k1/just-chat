/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {setGlobalOptions} = require("firebase-functions");
const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");

const projectId =
    process.env.GCLOUD_PROJECT ||
    process.env.GCP_PROJECT ||
    (process.env.FIREBASE_CONFIG && JSON.parse(process.env.FIREBASE_CONFIG).projectId) ||
    "your-project-id";

const firestoreDatabase = `projects/${projectId}/databases/just-chat-db`;
const chatDocumentPath = `${firestoreDatabase}/documents/chat/{messageId}`;
const functions = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");


// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });
admin.initializeApp();

functions.
exports.myFunction = functions.onDocumentCreated(
  "chat/{messageId}",
  (event) => {
    const data = event.data.data();
    return admin.messaging().send({
      notification: {
        title: data["username"],
        body: data["text"],
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
      },
      topic: "chat",
    });
  }
);

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

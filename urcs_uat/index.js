/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require( "firebase-functions" );
const admin = require( "firebase-admin" );
admin.initializeApp();

// Sends a notifications to all users when a new message is posted.
exports.sendNotifications = functions.firestore.document('sports/basketball/{name}').onUpdate(
    async (snapshot, context  ) => {
      // Notification details.
      const old_text = snapshot.before.data();
      const new_text = snapshot.after.data();

      if( old_text !== new_text ) {
        const payload = {
            tokens: [ new_text.FCMToken ],
            notification: {
              title: `Your data has changed, please`,
              body: "Queen",
              sound: "beep",
              channel_id: "NOTIF",
              android_channel_id: "NOTIF",
              priority: "high"
            }
          };

          try {
            await admin.messaging().sendEachForMulticast( payload );
          } catch (error) {
            console.log( "error", error )
          }
      }

     
  
      // Get the list of device tokens.
    //   const allTokens = await admin.firestore().collection('fcmTokens').get();
    //   const tokens = [];
    //   allTokens.forEach((tokenDoc) => {
    //     tokens.push(tokenDoc.id);
    //   });
  
    //   if (tokens.length > 0) {
    //     // Send notifications to all tokens.
    //     const response = await admin.messaging().sendToDevice(tokens, payload);
    //     await cleanupTokens(response, tokens);
    //     functions.logger.log('Notifications have been sent and tokens cleaned up.');
    //   }
    });
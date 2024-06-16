// firebaseInit.ts

import admin from "firebase-admin";

import fs from "fs";

const serviceAccountPath = "src/key/serviceAccountKey.json";
const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, "utf-8"));

const firebaseApp = admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: "gs://reststorebarber.appspot.com",
});

export default firebaseApp;

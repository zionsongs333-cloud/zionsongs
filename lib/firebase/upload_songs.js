const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const serviceAccount = require('./serviceAccountKey.json');
const { transliterate } = require('transliteration');

initializeApp({ credential: cert(serviceAccount) });
const db = getFirestore();


const hymnsData = require('./hymns.json');


async function uploadData() {
  console.log(`⏳ Uploading ${hymnsData.length} records to Firestore...`);

  for (const hymn of hymnsData) {

    const searchText = [
      hymn.title,
      hymn.lyrics?.Hindi || '',
      hymn.lyrics?.Malayalam || '',
      hymn.lyrics?.English || ''
    ].join(' ');

    hymn.searchText = transliterate(searchText).toLowerCase();

    await db.collection('hymns').doc(hymn.sr).set(hymn);

    console.log(`✅ Uploaded: ${hymn.title}`);
  }

  console.log("🎉 All songs are successfully uploaded!");
  process.exit();
}
uploadData().catch(console.error);
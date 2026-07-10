const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const serviceAccount = require('./serviceAccountKey.json');
const { transliterate } = require('transliteration');

initializeApp({ credential: cert(serviceAccount) });
const db = getFirestore();


const hymnsData = [
	{
		"sr": "ZS0002",
		"title": "ELLATILUM",
		"Key": "Maj",
		"Dedicated": "APPA",
		"year": "Tab 2022",
		"page": "2",
		"style": "",
		"tempo": "",
		"lyrics": {
      "English": "",
		"Hindi": "सबसे ऊँचा \r\nएक‌मात्र नाम है \r\nसार घुटने झुकाए वो नाम है \r\nहर जुबान गाएं \r\nएल येशू नाम \r\nसब भलाई में बदले वो नाम है\r\n\r\nCH : \r\nअद्भूत है येशू नाम \r\nअतिशय है येशू नाम \r\nआश्चर्यपूर्ण येशू नाम \r\nअधिकारपूर्ण येशू नाम \r\n\r\nलाखों में आप ही सुंदर है \r\nसीयोन के राजा है X 2\r\nआपके समान अप्पा आप ही\r\n\r\nस्वर्ग तक सीयोन को, \r\nउठाता वो नाम \r\nस्वर्ग सारा आराधित कर वो नाम \r\nमृत्यु पर विजयी, बनाता वो नाम \r\nसर्व पुनः स्थापित करता वो नाम\r\n\r\nCH : \r\nअनुग्रह है येशू नाम \r\nविजयी बनाता येशू नाम \r\nमुद्रित हैं येशू नाम \r\nसंरक्षण देता येशू नाम\r\n",
		"Malayalam": "ऐल्लाटीलुम मेलाय \r\nओरेओरु नामंम\r\nएल्ला मूळंगालुम मडंञीडुम नामंम \r\nएल्ला नावूम पाडुम एल येशू नामंम \r\nएल्लाम नन्मयक्याय माटुन्न नामंम\r\n\r\nCH\r\nअलभूद्‌माय नौममे अदीशयमाय  नाममे \r\nआश्चर्यमाय नाममे अधीगारमुळ्ळ नाममे \r\nअनुग्रहमाय नाममे विजयम नलगुम नाममे \r\nमुद्रीदमाय नाममे समरक्षणमेगुम नाममे\r\n\r\nपदीनाइरंगळिल सुन्दरने सीयोनिन राजावे (2) \r\nअँएक्यू तूल्यनाय अँउ मात्रम(2)\r\n"
  }
},
	{
		"sr": "ZS0003",
		"title": "ATHYUNNATHAN YESU APPA",
		"Key": "Maj",
		"Dedicated": "APPA",
		"year": "Tab 2022",
		"page": "3",
		"style": "",
		"tempo": "",
		"lyrics": {
    "English": "",
		"Hindi": "सर्वोन्नत येशु अप्पा \r\nसब कुछ मेरे भलाई में बदलते है\r\nपरिशुद्ध है मेरे अप्पा \r\nमेरे लिए सब पुनः स्थापित करते \r\n\r\nCH: \r\nआराधना पिता की\r\nआराधना येशु की \r\n\r\nओ मेरे प्रभु आओ मेरे पिता \r\nआप मेरे अभिलाष हो \r\nओ मेरे स्नेह, ओ जीव श्वास \r\nहर पल आप सर्व मेरे\r\n\r\nवेदना में मेरे संकट में भी \r\nस्वर आपका मुझे आश्वासन देता है \r\nमार्गदर्शी होकर, नीति के द्वारा \r\nले चलते मुझे येशु अप्पा \r\n\r\nमेरे पापों से जब मैं गिर जाऊँ, \r\nआपका स्वर मुझे सांत्वना देता \r\nमेरी कमियों को मेरे सहनों को,\r\nमेरे भले में बदलते हैं\r\n\r\nमुझेसे कुछ भी अम्मीद ना करे \r\nमुझे प्यार करते है मेरे अप्पा \r\nजैसे मुझे आप स्नेह करते, \r\nवैसे मैं आपसे स्नेह करू \r\n\r\nआपके सानिध्य में, मुझे स्ख लिजिए \r\nहर पल संभाल दिजिए \r\nआप में जुड़ जाने, एक हो जाने \r\nमेरा हृदय वांछित कर\r\n",
		"Malayalam": "अत्यून्नदन येशू अप्पन\r\nएनिक्येल्लाम नन्मक्याय माटुन्नू\r\nपरिशुद्धन एन्डेअप्पन\r\nएनिक्येल्लाम पुनः स्थापिक्युन्नू\r\n\r\nCH\r\nआराधना पिढ़ावे आराधना येशूवे\r\nयेन्डे दैवमे येन्डे तादने\r\nअँ आणेन अभीलाषम\r\nयेन्डे स्नेहमे जीव श्वासम\r\nअँ एन्नूम एन्न सर्वम\r\n\r\nवेदनयिल येन्नुम दूरीदंगळिल\r\nअँए स्वरम एन्ने आश्वस्सिप्पिक्युन्नू\r\nवळीकाटीयायेन्न नीधीयील्डे\r\nएन्ने नइक्युम येशू अप्पा\r\nएन्डे पाबंगळाल न्यान तळर्नीडुम्बोळ\r\nअँए स्वरम, एन्ने तळूगीडुन्नू\r\nएन्डे सहनगळे एन्डे करवगळे\r\nएन्डे नन्मक्याय माटीडुन्नू\r\n\r\nएन्निलन्निन्नोन्नुम प्रदीक्षीक्यादे\r\nएने स्नेहिक्युम एन्डे अप्पा\r\nअविडुन्नन्ने स्नेहिक्युम्‌पोले\r\nन्यान इन्न अँइल्ल स्नेहिक्युन्नू\r\nअँए कणमुम्बीलाय एन्ने नीरुत्तणमे\r\nअनूनीमीषम काकणमे\r\nअँइल्ल चेर्नीडूवान ओन्नाइडूवान\r\nएन्डे उळ्ळम वान्जीक्युन्नू\r\n"
  }
},
	{
		"sr": "ZS0004",
		"title": "PRAKASHANGALUDE PITHAVE",
		"Key": "Maj",
		"Dedicated": "APPA",
		"year": "Tab 2022",
		"page": "4",
		"style": "",
		"tempo": "",
		"lyrics": {
      "English": "",
		"Hindi": "",
		"Malayalam": "अप्पन्निलन्निन्तुम जनिच्चवळ न्यान\r\nसत्यत्तिन वजन्नताल उरुवायवळ\r\nन्यानुम ओरु प्रकाषम\r\nन्यानुम ओरू वेळिच्चम\r\n\r\nH\r\nप्रगाशंगळूडे पिदावे\r\nअनादियिल उळ्ळ प्रगाशेम\r\nहृद्यत्तिन निरविल निन्न एन अधरम\r\nअँए वाळती पाडीडुन्नू\r\nआराधिच्चीडुन्नू स्नेहिक्युन्नू अँए\r\nन्यगळ येशू अप्पा\r\n\r\nआदियिल अम्मा प्रक्षीयेपोल\r\nकूडोरुक्की अप्पन येनिक्याय\r\nआइरम आइरम चुम्बनमेगी\r\nआदि पिदाविल निक्षेबिच्चू\r\nएन्नोळम मयंञादे एन्नोळम उरंञादे\r\nएनिक्याय अध्वानिक्यूम येशू अप्पन\r\n\r\nउणंञी वीळर्न निलम्मेन्नपोले\r\nदाहार्तयाय न्यान केण नेरम\r\nस‌द्वार्त यागुम जीवजलम\r\nअप्पन एनिक्याय पगर्नू तन्नू\r\nओरुन्नालूम पीरीयगिल्ला\r\nओरुन्नालूम अगलूगील्ला\r\nअँए कणमुन्बील निन्नू न्यान मरयूगिल्ला\r\n"
  }
},
	{
		"sr": "ZS0005",
		"title": "YESU RAAJAAVODE (TAMIL)",
		"Key": "Min",
		"Dedicated": "APPA",
		"year": "Tab 2022",
		"page": "5",
		"style": "",
		"tempo": "",
		"lyrics": {
      "English": "",
		"Hindi": "",
		"Malayalam": "येशु राजावोड येशय्या\r\nअय्यावोड पडै तूलैवन\r\nसीयोनिन स्टार पोन्नार सार\r\nसीयानिन ओळीयाय वन्दारे\r\n\r\nसीयोनिन तलैवन यूद्धाकूल सिंगम\r\nपोन्नार सार तीरुम्बी वन्दाच्च\r\nवाळगा (2) पोन्नार राजा\r\nअवर वरवै सीयोन कोन्डाडूवोम\r\nयेन्ग सारोड नड्ये पारत्त\r\nइन्द सीयोनिन एदीरीगळ सेदरीडुम डा\r\n\r\nसेयलगळिल अवर सिंग्‌तैपोल\r\nइरयै तेडूगिन्ड सिंगतैपोल\r\nकोबत्तिन वाळागिन्ड्रवर\r\nयूदाविल मरैन्दीरुक्कुम सींगमाणवर\r\nइस्राएल मक्कळोड वेट्री\r\n"
  }
},
	{
		"sr": "ZS0006",
		"title": "ENNE KAANUNNA",
		"Key": "Min",
		"Dedicated": "APPA",
		"year": "Tab 2022",
		"page": "6",
		"style": "",
		"tempo": "",
		"lyrics": {
      "English": "",
		"Hindi": "मुझे देखते जो, मुझे जानते जो \r\nमेरे येशु अप्पा साथ मेरे\r\nअदृश्य जगह से वो मुझे देखते है \r\nवात्सल्यता से मुझे महान बनाते है \r\nअप्पा का स्वर हमेशा, कानों में गुंजती है 2 (2)\r\n\r\nCH : \r\nअप्पा…आराधना\r\nमेरे अपने... आराधना\r\n\r\nजीव वृक्ष की छांव में \r\nअप्पा मेरो पालन करते \r\nगले से लगाकर सदा \r\nचुंबन देते है\r\n\r\nअप्पा का स्वर हमेशा, कानों में गूंजती है\r\n\r\nस्नेह में परिशुद्ध और \r\nनिष्कलंक होने\r\nइम्मानुएल में मुझे \r\nचुन लिया है पिता ने \r\n\r\nअप्पा का स्वर हमेशा, कानों में गूंजती है\r\n",
		"Malayalam": "एन्ने काणुन्न एन्ने अरीयुन्न\r\nउन्हें येशु अप्पन कूडेयुन्ड\r\nकाणामरयत्तिन्न एन्ने कणुन्नू\r\nवात्सल्यत्ताल एन्ने वलीय\r\nअप्पन्डे स्वरम इन्नुम कादिल मूळंञीडुन्नू\r\n\r\nCH\r\nअप्पा ….आराधना\r\nएन्न स्वन्दमे आराधना\r\n\r\nजीव वृक्ष तणलिल न्निन्तुम\r\nअप्पन एन्ने कात्तीडून्नू\r\nमारोडच्चर्त एन्नुम\r\nच्चुम्बनम नलगीडुन्नू\r\n\r\nस्नेहत्तिल परिशुद्धराय\r\nनिष्कलंगराय तीरान\r\nइम्मानुएलिल एन्ने\r\nतीरंन्येडूत्तू पिदाव\r\n"
  }
},
	{
		"sr": "ZS0007",
		"title": "Amazing Grace",
		"Key": "Maj",
		"Dedicated": "APPA",
		"year": "1942",
		"page": "7",
		"style": "",
		"tempo": "",
		"lyrics": {
      "English": "D \r\nAmazing Grace, how \r\nG/D \r\nsweet the \r\nD \r\nsound\r\n  \r\nThat saved a wretch like \r\nA/D \r\nme\r\n  \r\nI \r\nD \r\nonce was \r\nD/F# \r\nlost but \r\nG \r\nnow am \r\nD \r\nfound\r\n  \r\nWas blind but \r\nA/D \r\nnow I \r\nD \r\nsee\r\n  \r\nVerse 2\r\n D \r\n'Twas Grace that taught my \r\nG/D \r\nheart to \r\nD \r\nfear\r\n  \r\nAnd Grace my fears re - \r\nA/D \r\nlieved\r\n  \r\nHow \r\nD \r\nprecious \r\nD/F# \r\ndid that \r\nG \r\nGrace \r\nD \r\nappear\r\n  \r\nThe hour I \r\nA/D \r\nfirst be\r\nD \r\nlieved\r\n  \r\nChorus\r\n  \r\nMy \r\nD/F# \r\nchains are \r\nG \r\ngone, I've been set \r\nD/F# \r\nfree\r\n  \r\nMy God, my \r\nG/B \r\nSavior has ransomed \r\nD/A \r\nme\r\n  \r\nAnd \r\nD/F# \r\nlike a \r\nG \r\nflood His mercy \r\nD/F# \r\nrains\r\n  \r\nUnending \r\nEm7 \r\nlove,\r\nA7 \r\n Amazing \r\nD \r\nGrace\r\n  \r\nVerse 3\r\n D \r\nThe Lord has promised \r\nG/D \r\ngood to \r\nD \r\nme\r\n  \r\nHis word my hope \r\nA/D \r\nsecures\r\n  \r\nHe \r\nD \r\nwill \r\nD/F# \r\nmy shield and \r\nG \r\nportion \r\nD \r\nbe\r\n  \r\nAs \r\nA/D \r\nlong as life \r\nD \r\nendures\r\n  \r\nVerse 4\r\n G/D \r\nThe \r\nD \r\nearth shall soon \r\nG/D \r\ndissolve like \r\nD \r\nsnow\r\n  \r\nThe sun forbear to \r\nA/D \r\nshine\r\n  \r\nBut \r\nD \r\nGod who \r\nD/F# \r\ncalled me \r\nG \r\nhere \r\nD \r\nbelow\r\n  \r\nWill \r\nA/D \r\nbe forever \r\nD \r\nmine\r\n  \r\nWill \r\nA/D \r\nbe forever \r\nD \r\nmine\r\n  \r\nYou are \r\nA/D \r\nforever \r\nD \r\nmine",
		"Hindi": "",
		"Malayalam": ""
    }
  }
]


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

    await db.collection('hymns')..doc(hymn.sr).set(hymn);

    console.log(`✅ Uploaded: ${hymn.title}`);
  }

  console.log("🎉 All songs are successfully uploaded!");
  process.exit();
}
uploadData().catch(console.error);
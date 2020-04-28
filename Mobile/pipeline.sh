#!/bin/sh
node ../quran.js Arabic ar_original_normalized > ar_original_normalized.json
node ../quran.js Arabic ar_normalized_phonetic > ar_normalized_phonetic.json
node ../quran.js Arabic ar_root_normalized_phonetic > ar_root_phonetic.json
node ../quran.js Arabic ar_root > ar_root.json
node ../quran.js Arabic ar_stems_normalized > ar_stems_normalized.json
node ../quran.js Arabic ar_stems_normalized_phonetic > ar_stems_normalized_phonetic.json

node ../quran.js ArabicNoor ar_original_normalized_noor > ar_original_normalized_noor.json
#node ../quran.js ArabicNoor ar_normalized_phonetic > ar_normalized_phonetic_noor.json  Same as Uthmani
node ../quran.js ArabicNoor ar_root_normalized_phonetic_noor > ar_root_phonetic_noor.json
node ../quran.js ArabicNoor ar_root_noor > ar_root_noor.json
node ../quran.js ArabicNoor ar_stems_normalized_noor > ar_stems_normalized_noor.json
node ../quran.js ArabicNoor ar_stems_normalized_phonetic_noor > ar_stems_normalized_phonetic_noor.json

node ../quran.js English en_normalized > en_normalized.json
node ../quran.js English standard > en_standard.json

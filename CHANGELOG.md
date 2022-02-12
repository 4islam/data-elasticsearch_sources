## 10.12.1
  * English Muhammad Ali translation fixed

## 10.12
  * Chinese and English Five Volume, commentaries are added 10.12

## 10.10
  * Chinese translation and English Five Volume Commentary translations added 10.12

## 10.9
  * Chinese translation and English Five Volume Commentary verse cross references added Excel file source 10.11

## 10.7
  * English 5 Volume based verse cross-references added. Corresponding Excel source file number 10.10

## 10.6
  * English Stemmer changed to Snowball one. Default one had issues (e.g. apes -> ap, not ape etc.)

## 10.5
  * Italian language added

## 10.4
  * ES Config updated for pipeline optimization

## 10.3:
  * Layer to split Topics added to calculate the most significant one

## 10.2:
  * Following Performance enhancements added to cluster (10x improvement for aggregation):
    - Numbers of shards increased to two per core
    - Pre-loading filesystem cache for readiness from cold start with:
      - Norms, doc values, terms dictionaries, postings lists and points ["nvd", "dvd", "tim", "doc", "dim"]

## 10.1:
  * Following Translation Added:
    - English Sir Muhammad Zaffarullah Khan sb ra

## 10.0:
  * Following Translation Added:
    - English Maulana Muhammad Ali ra

## 9.9:
  * Normalized matching fixed and updated
  * English Trigram layers for searching updated to leverage keyword tokenizer

## 9.8:
  * Arabic Noor to English mapping bugs fixed۔

## 9.7:
  * Performance related enhancements:
    - Shards and Replicas added
    - Numbers of shards reduced and replicas increases
  * export script updated to copy files to dockers
  * location of dictionary files moved to align with server

  * Index cleanup
    - All index=false removed from fields. These were added in the past to suppress some errors

## 9.6:
  * English Mapping for English Translation by Hadhrat Moulavi Sher Ali ra sahib added, with following stages:
    - English to Arabic Noor
    - Arabic Noor to English

## 9.5:
  * English Mapping for English Translation by Hadhrat Moulavi Sher Ali ra sahib added, with following stages:
    - English to Arabic
    - Arabic to English
    - Pipeline for Noor added

## 9.4:
  * The following translations added with all related layers:
    - EnglishPickthall
    - EnglishSahih
    - EnglishMaududi
    - EnglishAhmedAli
    - EnglishArberry
    - EnglishYusufAli
    - UrduMaududi
    - UrduAhmedAli

## 9.3:
  * Urdu Tafseer Wow Script Fixed

## 8.7:
  * Legacy support for Arabic_Noor removed

## 8.6:
  * Arabic_Noor renamed to ArabicNoor,  but Arabic_Noor is not removed for legacy supported

## 8.5:
  * Stop/pause signs are added back to Arabic

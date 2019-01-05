#!/usr/local/bin/node
var elasticsearch = require('elasticsearch');
var client = new elasticsearch.Client({
  host: 'localhost:9200',
  log: 'error'
});

function source(i) {
 client.search({
   index: 'hq',
   body: {
     query: {
       terms: {
         _id: [i]
       }
     }
   }
 }).then(function (resp) {
     var hits = resp.hits.hits
     var src = hits[0]._source

     analyze(src[arg_src],i,src.a,src.s)

 }, function (err) {
     console.trace(err.message);
 });
}

function analyze(src,i,a,s) {
 client.indices.analyze({
   index: 'hq',
   //analyzer : "ar_original_normalized",
   //analyzer : "ar_ngram_normalized",
   //analyzer:"query_phonetic",
   //analyzer:"ar_normalized_phonetic",
   analyzer: arg_analyzer,
   //analyzer:"en_normalized_simple",
   //analyzer:"ar_stems_normalized_phonetic",
   //analyzer:"ar_stems_normalized",
   //analyzer:"ar_root",
   //analyzer:"ur_normalized",
   //text:src
   text: src.substring(0)
   //text: src.split(' ').slice(110).join(" ")
   //text: "In the name of Allah"
}).then(function (resp) {
     var hits = resp.tokens; var str = ""
     for (var t in hits) {
        var T = hits[t]
        var TStr = '{"token":"'+T.token
                +'","start_offset":'+T.start_offset
                +',"end_offset":'+T.end_offset+'}';
        var TStr = T.token;

        //console.log(i, t, TStr);
        //str += t!=0?", " + TStr : TStr
        str += t!=0?" " + TStr : TStr
     }
     //console.log(src);


     // console.log("v")
     // console.log(hits[100])
     // console.log("^")
     // //console.log(hits)
     // console.log(hits.length)

     //console.log('{"id":'+i+', "tokens":[',str,'],"a":'+a+',"s":'+s+'}')
     //console.log('{"id":'+i+', "tokens":[',str,'],"a":'+a+',"s":'+s+'}')
     //console.log('{"id":'+i+', "src":"' + src + '", "tokens":[',str,'],"a":'+a+',"s":'+s+'}')
     if (myArgs.length) {
       console.log(str);

     } else {
        console.log('{"id":'+i+', "tokens":[',str,'],"a":'+a+',"s":'+s+'}')

        if(i<6348){console.log(",");source(i+1)}else{console.log("]")}
     }
     //if(i<290){source(i+1)}
     // if(i<5){source(i+33)}

 }, function (err) {
     console.trace(err.message);
 });
}


var arg_src="Arabic"
var arg_analyzer="standard"

var myArgs = process.argv.slice(2);
if (myArgs.length) {

  arg_src = process.argv[2]
  arg_analyzer = process.argv[3]

  //console.log(arg_src, arg_analyzer);

  analyze(arg_src,0)

} else {
  console.log("   Please add aurguments:  \
                  src text (Arabic|English|Urdu|French|German|Spanish), \
                  analyzer (ar_original_normalized|ar_stems_normalized|ar_root| \
                    ar_normalized_phonetic|ar_stems_normalized_phonetic|ar_root_phonetic\
                    ur_normalized|en_normalized)")


  console.log("[")
  //source(290);      //recurrance function call
  //source(592);      //recurrance function call
  //source(6322);      //recurrance function call
  source(1);
  //source(2844);
}

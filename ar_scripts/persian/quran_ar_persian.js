var elasticsearch = require('elasticsearch');
var client = new elasticsearch.Client({
  host: 'localhost:9200',
  log: 'error'
});

function source(i,len) {
  // console.log(i, len);
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

     analyze(src.Arabic.substring(0),i,len)
     //analyze(src.English,i,src.a,src.s)
     //analyze(src.Urdu,i,src.a,src.s)
     //analyze(src.Urdu,i,src.a,src.s)

 }, function (err) {
     console.trace(err.message);
 });
}

function analyze(src,i,len) {

 client.indices.analyze({
   index: 'hq',
   //analyzer : "ar_original_normalized",
   //analyzer : "ar_normalized_phonetic",
   analyzer : "ar_original_noor",
   //text:src
   text: src
   //text: "ديارھم"
   //text: "الارض "
   //text: src.split(' ').slice(110).join(" ")
   //text: "In the name of Allah"
}).then(function (resp) {
     var hits = resp.tokens; var str = ""
     for (var t in hits) {
        var T = hits[t]

        var TStr = ' ' + T.token.trim()
        str += t!=0?" " + TStr : TStr

     }

     console.log(str)
     //if(i<6348){console.log(",");source(i+1)}else{console.log("]")}
     if(i<len){source(i+1,len)}

 }, function (err) {
     console.trace(err.message);
 });
}

var myArgs = process.argv.slice(2);
key=1
len=100
 if (myArgs.length > 1) {
   key=parseInt(myArgs[0])
   len=parseInt(myArgs[1])
 }

 // if (myArgs.length) {
//
//     var readline = require('readline')
//
//     var rl = readline.createInterface({
//       input: process.stdin,
//       output: process.stdout,
//       terminal: false
//     })
//
//     var n = 0; dataArray =[]
//     rl.on('line', function (line) {
//       dataArray.push(line)
//       if (n==0){
//         analyze(line,n)
//       }
//       n++
//     })
//
// } else {
  source(key,key+len-1)
  //source(2844);
// }

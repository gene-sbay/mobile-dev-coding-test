const express = require('express');
const app = express();

const SEED_MAX_LEN = 25;

function getRandomSeed(length) {
   var result           = '';
   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
   var charactersLength = characters.length;
   for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
   }
   return result;
}

app.get('/nextSeed', function(req, res) {
  var seedLen = Math.floor(Math.random() * SEED_MAX_LEN) + 1;

  var seed = getRandomSeed(seedLen);
  res.send({'seed': seed});
});

app.listen(8000, function() {
  console.log('Express server listening on port 8000'); // eslint-disable-line
});

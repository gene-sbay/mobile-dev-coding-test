const express = require('express');
const app = express();


app.get('/ping', function(req, res) {
  var rand = Math.floor(Math.random() * 100) + 1;

  res.send('pong, random#: ' + rand);
});

app.get('/nextSeed', function(req, res) {
  var rand = Math.floor(Math.random() * 100) + 1;

  res.send({'seed': rand});
});

app.listen(8000, function() {
  console.log('Express server listening on port 8000'); // eslint-disable-line
});

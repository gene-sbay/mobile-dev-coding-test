const express = require('express');
const app = express();


app.get('/ping', function(req, res) {
  var rand = Math.floor(Math.random() * 100) + 1;

  res.send('pong, random#: ' + rand);
});

app.post('/upload', function(req, res) {
  // let sampleFile;
  // let uploadPath;

  // if (Object.keys(req.files).length == 0) {
  //   res.status(400).send('No files were uploaded.');
  //   return;
  // }

  // console.log('req.files >>>', req.files); // eslint-disable-line

  // sampleFile = req.files.sampleFile;

  // uploadPath = __dirname + '/uploads/' + sampleFile.name;

  // sampleFile.mv(uploadPath, function(err) {
  //   if (err) {
  //     return res.status(500).send(err);
  //   }

  //   res.send('File uploaded to ' + uploadPath);
  // });
});

app.listen(8000, function() {
  console.log('Express server listening on port 8000'); // eslint-disable-line
});
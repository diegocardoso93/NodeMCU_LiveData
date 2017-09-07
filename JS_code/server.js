const WebSocket = require('ws');
const express = require('express');
const path = require('path');
const app = express();
const server = require('http').createServer();

app.use(express.static(path.join(__dirname, '/public')));

const wss = new WebSocket.Server({server: server});

wss.on('connection', function (ws) {

  ws.on('message', function incoming(data) {
    wss.clients.forEach(function each(client) {
      if (client !== ws && client.readyState === WebSocket.OPEN) {
		client.send(data);
      }
    });
  });

});

server.on('request', app);
server.listen(8080, function () {
  console.log('Listening on http://localhost:8080');
});

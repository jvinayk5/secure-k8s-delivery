'use strict';
const { createServer } = require('./app');

const port = Number(process.env.PORT || 8080);
createServer().listen(port, () => {
  console.log(`node-service listening on ${port}`);
});

'use strict';
const test = require('node:test');
const assert = require('node:assert');
const { createServer } = require('../src/app');

function get(server, path) {
  return fetch(`http://127.0.0.1:${server.address().port}${path}`);
}

test('health endpoint returns ok', async (t) => {
  const server = createServer().listen(0);
  t.after(() => server.close());
  const res = await get(server, '/healthz');
  assert.strictEqual(res.status, 200);
  assert.deepStrictEqual(await res.json(), { status: 'ok' });
});

test('root returns service metadata', async (t) => {
  const server = createServer().listen(0);
  t.after(() => server.close());
  const res = await get(server, '/');
  const body = await res.json();
  assert.strictEqual(body.service, 'node-service');
});

test('unknown route returns 404', async (t) => {
  const server = createServer().listen(0);
  t.after(() => server.close());
  const res = await get(server, '/nope');
  assert.strictEqual(res.status, 404);
});

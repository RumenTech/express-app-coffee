_ = require "lodash"
env = process and process.env.NODE_ENV or "development";
PORT = 5000;

defaults =
  PORT: PORT
  brand: "Express app"

development =
  host: "http://localhost:" + PORT
  db: "mongodb://localhost:27017/testapp"
  ENV: "development"

production =
  host: "http://www.example.com"
  db: "",
  ENV: "production"

merged =
  development: _.extend(development, defaults)
  production: _.extend(production, defaults)

module.exports = merged[env]
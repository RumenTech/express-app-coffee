mongoose = require("mongoose")

serverRoot = "./"
config = require(serverRoot + "config")

mongoose.connect config.db

mongoose.connection.on "connected", ->
  console.log "Mongoose connection open to #{config.db}"

mongoose.connection.on "error", ->
  console.error "Mongoose connection error: #{config.db}"

mongoose.connection.on "disconnected", ->
  console.error "Mongoose connection disconnected"

module.exports = mongoose.connection
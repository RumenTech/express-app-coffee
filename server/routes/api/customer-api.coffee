router = require("express").Router()
mongoose = require("mongoose")
Q = require("q")


module.exports = ->

  Customer = mongoose.model("customers")

  # return router chained with various HTTP methods handlers
  router

    .post "/", (req, res, next) ->

      data = req.body

      func = Q.nbind Customer.create, Customer

      func data
        .then (doc) ->
          res.json doc
        .then null, (err) ->
          next err
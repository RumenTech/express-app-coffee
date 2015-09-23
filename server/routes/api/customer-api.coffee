router = require("express").Router()
mongoose = require("mongoose")
Q = require("q")

##
# API implementation for customers CRUD operation
#
#  Method | URL                                       | Description
#  -----------------------------------------------------------------
#     GET | /api/customers                            | Get all of the customers
#         | /api/customers?name=john                  | Get a customer specified by name
#         | /api/customers?email=example@gmail.com    | Get a customer specified by email
#         | /api/customers/:customer_id               | Get a customer specified by unique ID
#    POST | /api/customers                            | Create a single customer
#     PUT | /api/customers/:customer_id               | Update a single customer specified by unique ID
#  DELETE | /api/customers/:customer_id               | Delete a single customer specified by unique ID
# -----------------------------------------------------------------
##

module.exports = ->

  Customer = mongoose.model("customers")

  # return router chained with various HTTP methods handlers
  router
    .get "/", (req, res, next) ->
      qry = req.query
      Query = Customer.find()
      Query.and email: qry.email  if qry.email
      Query.and name: qry.name  if qry.name

      Q.nbind(Query.exec, Query)()
        .then (docs) ->
          res.json docs
        .then null, (err) ->
          next err

    .get "/:customerId", (req, res, next) ->
      customerId = req.params.customerId
      Q.nbind(Customer.findById, Customer)(customerId)
        .then (doc) ->
          res.json doc
        .then null, (err) ->
          next err

    .post "/", (req, res, next) ->
      data = req.body

      Q.nbind(Customer.create, Customer)(data)
        .then (doc) ->
          res.json doc
        .then null, (err) ->
          next err

    .put "/:customerId", (req, res, next) ->
      customerId = req.params.customerId;
      data = req.body;

      Q.nbind(Customer.findById, Customer)(customerId)
        .then (doc) ->
          Q.nbind(doc.modify, doc)(data)
        .spread (doc, numAffected) ->
          res.json doc
        .catch (err) ->
          next err

    .delete "/:customerId", (req, res, next) ->
      customerId = req.params.customerId

      Q.nbind(Customer.findById, Customer)(customerId)
        .then (doc) ->
          Q.nbind(doc.remove, doc)()
        .then (doc) ->
          res.json doc
        .catch (err) ->
          next err
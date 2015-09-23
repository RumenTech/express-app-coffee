routes = require("./index")

module.exports = (app) ->
  app.use "/api/customers", routes.api.customer()
supertest = require("supertest")
chai = require("chai")
expect = chai.expect

config = require("../../server/config")
server = supertest.agent(config.host)

describe "Customers API", ->

  newCustomerId = null

  it "should properly create a customer", (done) ->
    customer =
      name: "john"
      email: "john@example.com"
      barber: "Barber No.1"

    server
    .post "/api/customers"
    .send customer
    .end (err, res) ->
      throw err  if err
      expect(res)
        .to.have.property "status"
        .equals 200
      expect(res.body)
        .to.have.property "name"
        .equals "john"
      expect(res.body)
        .to.have.property "email"
        .equals "john@example.com"

      newCustomerId = res.body._id # Save ID of the new customer for future test
      done()

mongoose = require("mongoose")
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
_ = require("lodash")

customerSchema = new Schema(
  name:
    type: String
    required: true

  email:
    type: String
    required: true
    unique: true

  barber: String
,
  id: false
  toJSON:
    virtuals: true
)

fields = "name email barber"

customerSchema.methods.modify = (data, cb) ->
  _
    .extend this, _.pick(data, fields)
    .save cb

customerSchema.findByEmail = (email, cb) ->
  this.findOne email: email, cb

Customer = mongoose.model("customers", customerSchema)

module.exports = Customer
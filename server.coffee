# set up ========================
express = require('express')
app = express()                             # create our app with Express
mongoose = require('mongoose')              # mongoose for mongodb
bodyParser = require('body-parser')         # pull information from HTML POST (express4)
methodOverride = require('method-override') # simulate DELETE and PUT (express4)

serverRoot = './server'
config = require(serverRoot + '/config')

# configuration =================
app.use bodyParser.urlencoded(extended: 'true') # parse application/x-www-form-urlencoded
app.use bodyParser.json() # parse application/json
app.use methodOverride()

console.log config
app.set 'port', process.env.PORT or config.PORT
app.listen app.get('port'), '0.0.0.0', ->
  console.log 'App listening on port ' + app.get('port')
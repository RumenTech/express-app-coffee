module.exports = (app) ->

  # Catch 404 and forward to error handler
  app.use four_O_fourHandler = (req, res, next) ->
    next
      status: 404
      message: "Not Found"

  # Error handler
  app.use errorHandler = (err, req, res, next) ->
    status = err.status or 500
    if req.accepts "html"  or req.accepts "json"
      res
        .status status
        .json error: err
    else
      res
        .status 406
        .send "Not Acceptable"

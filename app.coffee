Koa = require 'koa'
Router = require 'koa-router'
bodyParser = require 'koa-bodyparser'
Pug = require 'koa-pug'
serve = require 'koa-static'
fs = require 'fs'
mongoose = require 'mongoose'

# Server
app = new Koa()
router = new Router()
pug = new Pug(
  viewPath: './mvc/views'
  basedir: './mvc/views'
  app: app
)

# Mongoose
mongoose.connect 'mongodb://localhost/jobpost', useMongoClient: true
mongoose.Promise = global.Promise

# Body parser
app.use(bodyParser())

# Serve static content
app.use(serve(__dirname + '/public'))

# Custom middlewares
middlewares = require('./mvc/middlewares.coffee').middlewares
for k,v of middlewares
  app.use v

# Dynamically import controllers
for file in fs.readdirSync('./mvc/controllers')
  if file.substr(-7) == '.coffee'
    route = require './mvc/controllers/' + file
    route.controller router

# Start server
app
  .use(router.routes())
  .use(router.allowedMethods())
app.listen(9898)

mongoose = require 'mongoose'

# Import models
Job = require '../models/job.coffee'

module.exports.controller = (router) ->

  # Show jobs
  router.get '/', (ctx) ->
    Job.find (err, jobs) ->
      ctx.render('home', jobs: jobs)

  # Create new job
  router.post '/job', (ctx) ->
    job = new Job
      title: ctx.request.body.title
      url: ctx.request.body.url
      source: ctx.request.body.source

    await job.save (err) ->
      console.log err if err

    ctx.body = 'Job posted'

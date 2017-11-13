request = require 'request-promise'

module.exports.middlewares =

  # Reddit
  forhire: (ctx, next) ->
    jobs = []
    await request 'http://www.reddit.com/r/forhire/search/.json?q=(title:"[hiring]"+OR+flair:Hiring)&sort=new&restrict_sr=on&t=day', (err, res, body) ->
      body = JSON.parse(body);
      for post in body.data.children
        jobs.push
          title: post.data.title
          url: 'https://reddit.com/' + post.data.permalink
          source: 'reddit/r/forhire'

    ctx.redditJobs = jobs
    next()


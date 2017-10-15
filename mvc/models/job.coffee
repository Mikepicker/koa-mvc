mongoose = require 'mongoose'

jobSchema = new mongoose.Schema
  title: String,
  url: String,
  source: String

Job = mongoose.model 'job', jobSchema

module.exports = Job

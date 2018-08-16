process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

environment.plugins.get("Manifest").opts.writeToFileEmit = process.env.NODE_ENV !== "test"

config = environment.toWebpackConfig()
config.devtool = "inline-source-map"
module.exports = config


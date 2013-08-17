env = process.env.NODE_ENV or "development"

settings =
  production:
    redis:
      host: 'crestfish.redistogo.com'
      port: 9872
      pass: 'faea961e4f9c8b0ba7472429880e48e0'
      
    conn_str: process.env.MONGO_URI
    main_api_key: 'asdf'
    api_host: 'localhost'
    api_port: '3001'
  staging:
    redis:
      host: 'crestfish.redistogo.com'
      port: 9872
      pass: 'faea961e4f9c8b0ba7472429880e48e0'
    conn_str: process.env.MONGO_URI
    main_api_key: 'asdf'
    api_host: 'localhost'
    api_port: '3001'
  development:
    redis:
      host: 'localhost'
      port: 6379
    conn_str: 'mongodb://localhost/loudr'
    main_api_key: 'asdf'
    api_host: 'localhost'
    api_port: '3001'

module.exports.settings = settings[env]
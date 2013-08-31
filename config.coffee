env = process.env.NODE_ENV or "development"
redis_pw = process.env.REDIS_PW

settings =
  production:
    redis:
      host: 'crestfish.redistogo.com'
      port: 9872
      pass: redis_pw
    conn_str: process.env.MONGO_URI
    main_api_key: 'asdf'
    api_host: '127.0.0.1'
    api_port: '15001'
  staging:
    redis:
      host: 'crestfish.redistogo.com'
      port: 9872
      pass: redis_pw
    conn_str: process.env.MONGO_URI
    main_api_key: 'asdf'
    api_host: '127.0.0.1'
    api_port: '15001'
  development:
    redis:
      host: 'localhost'
      port: 6379
    conn_str: 'mongodb://localhost/loudr'
    main_api_key: 'asdf'
    api_host: '127.0.0.1'
    api_port: '15001'

module.exports.settings = settings[env]
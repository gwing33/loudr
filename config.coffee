env = process.env.NODE_ENV or "development"

settings =
  production:
    conn_str: 'mongodb://localhost/loudr'
    main_api_key: 'asdf'
    api_host: 'localhost'
    api_port: '3001'
  staging:
    conn_str: 'mongodb://localhost/loudr'
    main_api_key: 'asdf'
    api_host: 'localhost'
    api_port: '3001'
  development:
    conn_str: 'mongodb://localhost/loudr'
    main_api_key: 'asdf'
    api_host: 'localhost'
    api_port: '3001'

module.exports.settings = settings[env]
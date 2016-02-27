import $ from 'jquery'

host = if __PROD__ then 'https://sanders-api.herokuapp.com' else 'http://localhost:3000'

module.exports = 
  request: (path, method, token, data, success, failure) ->
    $.ajax
      url: "#{host}/api/v1#{path}"
      method: method
      headers:
        'Authorization': "Bearer #{token}"
      data: data
      success: success
      failure: failure

  get: (path, token, data, success, failure=null) ->
    @request(path, 'GET', token, data, success, failure)

  post: (path, token, data, success, failure=null) ->
    @request(path, 'POST', token, data, success, failure)

  put: (path, token, data, success, failure=null) ->
    @request(path, 'PUT', token, data, success, failure)

  delete: (path, token, data, success, failure=null) ->
    @request(path, 'DELETE', token, data, success, failure)
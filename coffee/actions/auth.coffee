import Client    from 'client'
import constants from 'constants/all'

module.exports =
  login: (authToken) ->
    success = (response) =>
      @dispatch(constants.AUTH.LOGIN_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.AUTH.LOGIN_FAILURE, response)

    Client.get('/users/me', authToken, {}, success, failure)

  logout: ->
    @dispatch(constants.AUTH.LOGOUT)

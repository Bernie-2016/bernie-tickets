import Fluxxor   from 'fluxxor'
import constants from 'constants'

module.exports = Fluxxor.createStore
  initialize: ->
    if localStorage.getItem('authToken')
      @loggedIn = true
      @authToken = localStorage.getItem('authToken')
    else
      @loggedIn = false
      @authToken = null
    @loaded = true
    @error = false
    @bindActions(constants.AUTH.LOGIN, @onLogin)
    @bindActions(constants.AUTH.LOGOUT, @onLogout)

  onLogin: (payload) ->
    @loggedIn = true
    @authToken = payload.accessToken
    localStorage.setItem('authToken', @authToken)
    @emit('change')

  onLogout: ->
    @loggedIn = false
    @authToken = null
    localStorage.removeItem('authToken')
    @emit('change')

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
    @logout = false
    @bindActions(constants.AUTH.LOGIN, @onLogin)
    @bindActions(constants.AUTH.LOGOUT, @onLogout)
    @bindActions(constants.ADMIN.FORM.LOAD_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORMS.LOAD_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORMS.CREATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORM.UPDATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORM.DESTROY_FAILURE, @onFailure)

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

  onFailure: (response) ->
    return unless response.responseJSON.error is 'bad_token'
    @logout = true
    @emit('change')
    @logout = false

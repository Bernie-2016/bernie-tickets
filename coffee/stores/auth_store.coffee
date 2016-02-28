import Fluxxor   from 'fluxxor'
import constants from 'constants'

module.exports = Fluxxor.createStore
  initialize: ->
    if localStorage.getItem('authToken')
      @loggedIn = true
      @authToken = localStorage.getItem('authToken')
      @role = localStorage.getItem('role')
    else
      @loggedIn = false
      @authToken = null
      @role = null
    @loaded = true
    @error = false
    @logout = false
    @bindActions(constants.AUTH.LOGIN_SUCCESS, @onLoginSuccess)
    @bindActions(constants.AUTH.LOGIN_FAILURE, @onFailure)
    @bindActions(constants.AUTH.LOGOUT, @onLogout)
    @bindActions(constants.ADMIN.FORM.LOAD_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORMS.LOAD_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORMS.CREATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORM.UPDATE_FAILURE, @onFailure)
    @bindActions(constants.ADMIN.FORM.DESTROY_FAILURE, @onFailure)

  onLoginSuccess: (response) ->
    @loggedIn = true
    @authToken = response.authToken
    @role = response.role
    localStorage.setItem('authToken', @authToken)
    localStorage.setItem('role', @role)
    @emit('change')

  onLogout: ->
    @loggedIn = false
    @authToken = null
    @role = null
    localStorage.removeItem('authToken')
    localStorage.removeItem('role')
    @emit('change')

  onFailure: (response) ->
    return unless response.responseJSON.error is 'bad_token'
    @logout = true
    @emit('change')
    @logout = false

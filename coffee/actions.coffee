import Client    from 'client'
import constants from 'constants'

module.exports =
  auth:
    login: (accessToken) ->
      @dispatch(constants.AUTH.LOGIN, accessToken: accessToken)

    logout: ->
      @dispatch(constants.AUTH.LOGOUT)

  admin:
    forms:
      load: (authToken) ->
        @dispatch(constants.ADMIN.FORMS.LOAD)

        success = (response) =>
          @dispatch(constants.ADMIN.FORMS.LOAD_SUCCESS, response)

        failure = =>
          @dispatch(constants.ADMIN.FORMS.LOAD_FAILURE)

        Client.get('/forms', authToken, {}, success, failure)

    form:
      create: (payload) ->
        @dispatch(constants.ADMIN.FORM.CREATE)

        success = (response) =>
          @dispatch(constants.ADMIN.FORM.CREATE_SUCCESS, response)

        failure = =>
          @dispatch(constants.ADMIN.FORM.CREATE_FAILURE)

        Client.post('/forms', payload.authToken, payload.data, success, failure)

        $.post("#{host}/api/v1/forms", success).fail(failure)

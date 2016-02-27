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
        @dispatch(constants.ADMIN.FORMS.CREATE)

        success = (response) =>
          @dispatch(constants.ADMIN.FORMS.CREATE_SUCCESS, response)

        failure = =>
          @dispatch(constants.ADMIN.FORMS.CREATE_FAILURE)

        Client.post('/forms', payload.authToken, payload.data, success, failure)

      update: (payload) ->
        @dispatch(constants.ADMIN.FORM.UPDATE)

        success = (response) =>
          @dispatch(constants.ADMIN.FORM.UPDATE_SUCCESS, response)

        failure = =>
          @dispatch(constants.ADMIN.FORM.UPDATE_FAILURE)

        Client.put("/forms/#{payload.id}", payload.authToken, payload.data, success, failure)

      destroy: (payload) ->
        @dispatch(constants.ADMIN.FORM.DESTROY, payload.id)

        success = (response) =>
          @dispatch(constants.ADMIN.FORM.DESTROY_SUCCESS, response)

        failure = =>
          @dispatch(constants.ADMIN.FORM.DESTROY_FAILURE)

        Client.delete("/forms/#{payload.id}", payload.authToken, {}, success, failure)

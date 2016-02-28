import Client    from 'client'
import constants from 'constants/all'

module.exports =
  load: (payload) ->
    @dispatch(constants.ADMIN.FORM.LOAD)

    success = (response) =>
      @dispatch(constants.ADMIN.FORM.LOAD_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.FORM.LOAD_FAILURE, response)

    Client.get("/forms/#{payload.slug}", payload.authToken, {}, success, failure)

  create: (payload) ->
    @dispatch(constants.ADMIN.FORMS.CREATE)

    success = (response) =>
      @dispatch(constants.ADMIN.FORMS.CREATE_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.FORMS.CREATE_FAILURE, response)

    Client.post('/forms', payload.authToken, payload.data, success, failure)

  update: (payload) ->
    @dispatch(constants.ADMIN.FORM.UPDATE)

    success = (response) =>
      @dispatch(constants.ADMIN.FORM.UPDATE_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.FORM.UPDATE_FAILURE, response)

    Client.put("/forms/#{payload.id}", payload.authToken, payload.data, success, failure)

  destroy: (payload) ->
    @dispatch(constants.ADMIN.FORM.DESTROY, payload.id)

    success = (response) =>
      @dispatch(constants.ADMIN.FORM.DESTROY_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.FORM.DESTROY_FAILURE, response)

    Client.delete("/forms/#{payload.id}", payload.authToken, {}, success, failure)


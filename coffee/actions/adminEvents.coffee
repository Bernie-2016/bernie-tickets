import Client    from 'client'
import constants from 'constants/all'

module.exports =
  load: (authToken) ->
    @dispatch(constants.ADMIN.EVENTS.LOAD)

    success = (response) =>
      @dispatch(constants.ADMIN.EVENTS.LOAD_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.EVENTS.LOAD_FAILURE, response)

    Client.get('/events', authToken, {}, success, failure)

  create: (payload) ->
    @dispatch(constants.ADMIN.EVENTS.CREATE)

    success = (response) =>
      @dispatch(constants.ADMIN.EVENTS.CREATE_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.EVENTS.CREATE_FAILURE, response)

    Client.post('/events', payload.authToken, payload.data, success, failure)

  update: (payload) ->
    @dispatch(constants.ADMIN.EVENTS.UPDATE)

    success = (response) =>
      @dispatch(constants.ADMIN.EVENTS.UPDATE_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.EVENTS.UPDATE_FAILURE, response)

    Client.put("/events/#{payload.id}", payload.authToken, payload.data, success, failure)

  destroy: (payload) ->
    @dispatch(constants.ADMIN.EVENTS.DESTROY, payload.id)

    success = (response) =>
      @dispatch(constants.ADMIN.EVENTS.DESTROY_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.EVENTS.DESTROY_FAILURE, response)

    Client.delete("/events/#{payload.id}", payload.authToken, {}, success, failure)

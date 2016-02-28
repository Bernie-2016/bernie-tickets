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

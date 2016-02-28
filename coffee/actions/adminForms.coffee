import Client    from 'client'
import constants from 'constants/all'

module.exports =
  load: (authToken) ->
    @dispatch(constants.ADMIN.FORMS.LOAD)

    success = (response) =>
      @dispatch(constants.ADMIN.FORMS.LOAD_SUCCESS, response)

    failure = (response) =>
      @dispatch(constants.ADMIN.FORMS.LOAD_FAILURE, response)

    Client.get('/forms', authToken, {}, success, failure)

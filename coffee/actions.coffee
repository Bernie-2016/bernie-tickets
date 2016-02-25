import $         from 'jquery'
import constants from 'constants'

host = if __PROD__ then 'https://sanders-api.herokuapp.com' else 'http://localhost:3000'

module.exports =
  auth:
    login: (accessToken) ->
      @dispatch(constants.AUTH.LOGIN, accessToken: accessToken)

    logout: ->
      @dispatch(constants.AUTH.LOGOUT)

  admin:
    forms:
      load: ->
        @dispatch(constants.ADMIN.FORMS.LOAD)

        success = (response) =>
          @dispatch(constants.ADMIN.FORMS.LOAD_SUCCESS, response)

        failure = =>
          @dispatch(constants.ADMIN.FORMS.LOAD_FAILURE)

        $.get("#{host}/api/v1/forms", success).fail(failure)

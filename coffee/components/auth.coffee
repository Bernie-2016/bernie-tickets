import React       from 'react'
import Fluxxor     from 'fluxxor'
import { History } from 'react-router'
import query       from 'query-string'

module.exports = React.createClass
  displayName: 'Auth'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('AuthStore')
    
    {
      loggedIn: store.loggedIn
    }

  login: ->
    params = query.stringify(
      response_type: 'token'
      client_id: '460408574804-mlgtiucon06jaadqpltkf36u21hvku9b.apps.googleusercontent.com'
      scope: 'profile email'
      redirect_uri: if __PROD__ then 'https://bernietickets.com/callback' else 'http://localhost:8080/callback'
    )
    window.location.href = "https://accounts.google.com/o/oauth2/v2/auth?#{params}"

  componentDidMount: ->
    hash = query.parse(location.hash.substr(1))
    @props.flux.actions.auth.login(hash.access_token) if hash.access_token

  componentDidUpdate: ->
    @history.pushState(null, '/admin') if @state.loggedIn

  render: ->
    <div className={'forms-admin'}>
      <form onSubmit={@handleSubmit}>
        <a href='#' className='btn' onClick={@login}>
          Login
        </a>
      </form>
    </div>

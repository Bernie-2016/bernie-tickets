import ReactDOM      from 'react-dom'
import React         from 'react'
import { Router }    from 'react-router'
import Fluxxor       from 'fluxxor'
import createHistory from 'history/lib/createBrowserHistory'
import actions       from 'actions/all'
import routes        from 'routes'
import stores        from 'stores/all'

flux = new Fluxxor.Flux(stores, actions)

createFluxComponent = (Component, props) ->
  <Component {...props} flux={flux} />

container = document.createElement('div')
document.body.appendChild(container)
ReactDOM.render(<Router routes={routes} flux={flux} createElement={createFluxComponent} history={createHistory()} />, container)

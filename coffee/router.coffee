import ReactDOM          from 'react-dom'
import React             from 'react'
import { Router, Route } from 'react-router'
import createHistory     from 'history/lib/createBrowserHistory'
import FirebaseUtils     from 'utils/firebaseUtils'

# Require route components.
import App        from 'components/app'
import Form       from 'components/form'
import Login      from 'components/login'
import Admin      from 'components/admin'
import AdminForms from 'components/adminForms'
import AdminForm  from 'components/adminForm'

# Define up and render routes.
router = (
  <Router history={createHistory()}>
    <Route component={App}>
      <Route component={Admin}>
        <Route path='/admin/forms/:slug' component={AdminForm} />
        <Route path='/admin/forms' component={AdminForms} />
        <Route path='/admin' component={AdminForms} />
      </Route>

      <Route path='login' component={Login} />
      <Route path='/:slug' component={Form} />
      <Route path='/' component={Form} />
    </Route>
  </Router>
)

container = document.createElement('div')
document.body.appendChild(container)
ReactDOM.render(router, container)

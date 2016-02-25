import React         from 'react'
import { Route }     from 'react-router'

import App           from 'components/app'
import Form          from 'components/form'
import Auth          from 'components/auth'
import Authenticated from 'components/authenticated'
import AdminForms    from 'components/admin/forms'
import AdminForm     from 'components/admin/form'

module.exports = (
  <Route component={App}>
    <Route component={Authenticated}>
      <Route path='/admin/forms/:slug' component={AdminForm} />
      <Route path='/admin/forms' component={AdminForms} />
      <Route path='/admin' component={AdminForms} />
    </Route>

    <Route path='login' component={Auth} />
    <Route path='callback' component={Auth} />
    <Route path='/:slug' component={Form} />
    <Route path='/' component={Form} />
  </Route>
)

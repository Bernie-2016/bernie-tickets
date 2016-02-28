import React         from 'react'
import { Route }     from 'react-router'

import App           from 'components/app'
import Form          from 'components/form'
import Auth          from 'components/auth'
import Authenticated from 'components/authenticated'
import AdminForms    from 'components/admin/forms'
import AdminForm     from 'components/admin/form'
import AdminNewForm  from 'components/admin/newForm'
import AdminEditForm from 'components/admin/editForm'
import AdminEvents   from 'components/admin/events'

module.exports = (
  <Route component={App}>
    <Route component={Authenticated}>
      <Route path='/admin/forms/new' component={AdminNewForm} />
      <Route path='/admin/forms/:id/edit' component={AdminEditForm} />
      <Route path='/admin/forms/:id' component={AdminForm} />
      <Route path='/admin/forms' component={AdminForms} />
      <Route path='/admin/events/campaign' component={AdminEvents} />
      <Route path='/admin/events/internal' component={AdminEvents} />
      <Route path='/admin' component={AdminForms} />
    </Route>

    <Route path='login' component={Auth} />
    <Route path='callback' component={Auth} />
    <Route path='/:slug' component={Form} />
    <Route path='/' component={Form} />
  </Route>
)

import React          from 'react'
import { Route }      from 'react-router'

import App            from 'components/app'
import Form           from 'components/form'
import Auth           from 'components/auth'
import Authenticated  from 'components/authenticated'
import AdminForms     from 'components/admin/forms/index'
import AdminForm      from 'components/admin/forms/show'
import AdminNewForm   from 'components/admin/forms/new'
import AdminEditForm  from 'components/admin/forms/edit'
import AdminEvents    from 'components/admin/events/index'
import AdminEvent     from 'components/admin/events/show'
import AdminNewEvent  from 'components/admin/events/new'
import AdminEditEvent from 'components/admin/events/edit'

module.exports = (
  <Route component={App}>
    <Route component={Authenticated}>
      <Route path='/admin/forms/new' component={AdminNewForm} />
      <Route path='/admin/forms/:id/edit' component={AdminEditForm} />
      <Route path='/admin/forms/:id' component={AdminForm} />
      <Route path='/admin/forms' component={AdminForms} />
      <Route path='/admin/events/new' component={AdminNewEvent} />
      <Route path='/admin/events/campaign' component={AdminEvents} />
      <Route path='/admin/events/internal' component={AdminEvents} />
      <Route path='/admin/events/:id/edit' component={AdminEditEvent} />
      <Route path='/admin/events/:id' component={AdminEvent} />
      <Route path='/admin' component={AdminForms} />
    </Route>

    <Route path='login' component={Auth} />
    <Route path='callback' component={Auth} />
    <Route path='/:slug' component={Form} />
    <Route path='/' component={Form} />
  </Route>
)

import Client      from 'client'
import constants   from 'constants/all'
import auth        from 'actions/auth'
import adminForms  from 'actions/adminForms'
import adminForm   from 'actions/adminForm'
import adminEvents from 'actions/adminEvents'

module.exports =
  auth: auth
  admin:
    forms: adminForms
    form: adminForm
    events: adminEvents

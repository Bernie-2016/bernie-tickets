import React                    from 'react'
import { History, Link }        from 'react-router'
import { Nav, Navbar, NavItem } from 'react-bootstrap'
import Fluxxor                  from 'fluxxor'
import noty                     from 'noty'

module.exports = React.createClass
  displayName: 'Authenticated'
  
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('AuthStore')
    
    {
      loggedIn: store.loggedIn
    }

  signOut: ->
    @props.flux.actions.auth.logout()

  componentWillMount: ->
    unless @state.loggedIn
      noty(
        theme: 'relax'
        text: 'You must log in first.'
        layout: 'topRight'
        type: 'error'
        timeout: 3000
      )
      @history.pushState(null, '/login')

  componentDidUpdate: ->
    @history.pushState(null, '/login') unless @state.loggedIn

  render: ->
    <div>
      <div className='row'>
        <Navbar>
          <Navbar.Header>
            <Navbar.Brand>
              <Link to='/admin'>Bernie Events</Link>
            </Navbar.Brand>
            <Navbar.Toggle />
          </Navbar.Header>
          <Navbar.Collapse>
            <Nav>
              <NavItem eventKey={1} href='/admin'>Forms</NavItem>
            </Nav>
            <Nav pullRight>
              <NavItem eventKey={2} onClick={@signOut} href='#'>Sign Out</NavItem>
            </Nav>
          </Navbar.Collapse>
        </Navbar>
      </div>
      {React.cloneElement(@props.children, { loginRedirect: !@state.loggedIn })}
    </div>

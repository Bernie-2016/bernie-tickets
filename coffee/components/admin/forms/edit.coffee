import React             from 'react'
import Fluxxor           from 'fluxxor'
import { History, Link } from 'react-router'
import { Row, Col }      from 'react-bootstrap'
import Loader            from 'react-loader'
import _                 from 'lodash'
import Form              from 'components/admin/forms/form'

module.exports = React.createClass
  displayName: 'AdminEditForm'

  contextTypes:
    router: React.PropTypes.func

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('AuthStore', 'FormsStore'), History]

  getStateFromFlux: ->
    store = @props.flux.store('FormsStore')
    form = _.find(store.forms, id: parseInt(@props.params.id)) || {}

    {
      title: form.title
      slug: form.slug
      fields: form.questions || []
      loaded: store.loaded
      error: store.error
      updatedId: store.updatedId
    }

  set: (payload) ->
    @setState(payload)

  submit: (e) ->
    e.preventDefault()

    @props.flux.actions.admin.form.update(
      authToken: @props.flux.store('AuthStore').authToken
      id: @props.params.id
      data:
        form:
          title: @state.title
          slug: @state.slug
          questions_attributes: @state.fields
    )

  componentDidMount: ->
    @props.flux.actions.admin.forms.load(@props.flux.store('AuthStore').authToken) unless @state.loaded

  componentDidUpdate: ->
    @history.pushState(null, "/admin/forms/#{@state.updatedId}") if @state.updatedId

  render: ->
    <Loader loaded={@state.loaded}>
      <Row>
        <Col md={6} xs={12}>
          <h1>Edit Form</h1>
          <Form title={@state.title} slug={@state.slug} fields={@state.fields} set={@set} submit={@submit} submitText='Update Form' /> 
        </Col>
      </Row>
    </Loader>

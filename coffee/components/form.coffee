import React       from 'react'
import Fluxxor     from 'fluxxor'
import { Input }   from 'react-bootstrap'
import Mailcheck   from 'mailcheck'
import QRCode      from 'qrcode.react'
import $           from 'jquery'
import MaskedInput from 'components/maskedInput'

module.exports = React.createClass
  displayName: 'Form'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin('FormStore')]

  contextTypes:
    router: React.PropTypes.func

  getStateFromFlux: ->
    store = @props.flux.store('FormStore')

    {
      title: store.title
      fields: store.fields || []
      loaded: store.loaded
      error: store.error
      view: 'FORM'
      suggestion: {}
      showSuggestion: false
      form: false
      qrString: ''
      firstName: ''
      lastName: ''
      phone: ''
      email: ''
      zip: ''
      canText: false
    }

  checkEmail: (e) ->
    Mailcheck.run(
      email: @state.email
      suggested: (suggestion) =>
        @setState(suggestion: suggestion, showSuggestion: true)
      empty: =>
        @setState(suggestion: {}, showSuggestion: false)
    )

  acceptSuggestion: (e) ->
    return if $(e.target).is('.x')
    @setState(email: @state.suggestion.full)
    @setState(suggestion: {}, showSuggestion: false)

  declineSuggestion: ->
    @setState(suggestion: {}, showSuggestion: false)

  componentDidMount: ->
    @props.flux.actions.admin.form.load(
      slug: @props.params.slug
      @props.flux.store('AuthStore').authToken
    )

  submitForm: (e) ->
    e.preventDefault()

    data =
      first_name: @state.firstName
      last_name: @state.lastName
      phone: @state.phone
      email: @state.email
      zip: @state.zip
      canText: @state.canText

    # Stringify basic fields.
    allFields = [
      'first_name'
      'last_name'
      'phone'
      'email'
      'zip'
      'canText'
    ]
    string = JSON.stringify(allFields.map( (key) -> data[key] )).slice(1, -1)
    canvas = $('canvas')[0]
    @setState(view: 'TICKET', qrString: string, dataUrl: canvas.toDataUrl())

  onPrint: (e) ->
    e.preventDefault()
    windowContent = "<html><body><img src='#{@state.dataUrl}' style='width: 400px;' /></body></html>"
    printWin = window.open()
    printWin.document.open()
    printWin.document.write(windowContent)
    printWin.document.close()
    printWin.focus()
    printWin.print()
    printWin.close()

  render: ->
    <div>
      <section className={"form #{'hidden' unless @state.view is 'FORM'}"}>
        <h2>
          Event Registration
        </h2>
        <hr />
        {if @state.error
          <p className='no-form'>
            No form exists at this URL -- please double-check spelling or contact event staff.
          </p>
        else
          <form className='signup'>
            <Input type='text' placeholder='First Name' required={true} value={@state.firstName} onChange={ (e) => @setState(firstName: e.target.value) } />
            <Input type='text' placeholder='Last Name' required={true} value={@state.lastName} onChange={ (e) => @setState(lastName: e.target.value) } />
            <MaskedInput type='tel' placeholder='Cell Phone #' mask='(111) 111-1111' required={@state.canText} value={@state.phone} onChange={ (e) => @setState(phone: e.target.value) } />
            <Input type='email' placeholder='Email Address' required={true} onBlur={@checkEmail} value={@state.email} onChange={ (e) => @setState(email: e.target.value) } />
            { if @state.showSuggestion
              <div className='email-suggestion' onClick={@acceptSuggestion}>
                <span className='suggestion'>
                  Did you mean {@state.suggestion.address}@<strong>{@state.suggestion.domain}</strong>?
                </span>
                <span className='x' onClick={@declineSuggestion}>X</span>
              </div>
            }

            <MaskedInput name='zip' placeholder='Zip Code' type='tel' mask='11111' required={true} value={@state.zip} onChange={ (e) => @setState(zip: e.target.value) } />

            {for field in @state.fields when field.type is 'text'
              <Input className='custom_field' key={field.id} type='text' placeholder={field.title} required={true} />
            }

            <div className='checkboxgroup'>
              <Input type='checkbox' id='canText' onChange={ (e) => @setState(canText: $(e.target).is(':checked')) } />
              <label htmlFor='canText' className='checkbox-label'>
                Receive text msgs from Bernie 2016
                <span className='disclaimer'><br />Msg and data rates may apply</span>
              </label>
            </div>

            {for field in @state.fields when field.type is 'checkbox'
              <div className='checkboxgroup' key={field.id}>
                <Input type='checkbox' />
                <label className='checkbox-label'>
                  {field.title}
                </label>
              </div>
            }

            <a href='#' className='btn' onClick={@submitForm}>Sign Up</a>
          </form>
        }
      </section>

      <section className={"ticket #{'hidden' unless @state.view is 'TICKET'}"}>
        <h2>Bernie 2016</h2>
        <QRCode value={@state.qrString} size={300} fgColor='#147FD7' />
        <h2>Event Ticket</h2>
        <a className='btn' onClick={@onPrint}>
          Print
        </a><br />
        <a href={@state.dataUrl} id='save' download='ticket.png' className='btn'>
          Save
        </a>
      </section>
    </div>

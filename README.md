# Clarke Documentation

Clarke is a ruby [DSL](https://en.wikipedia.org/wiki/Domain-specific_language) library designed to easily build conversational bots. It abstracts the UI platform used from the core of the application. Using the UI libraries, you can use your Clarke application on multiple platforms with the exact same code.

## Table of Contents

* [Clarke Documentation](#clarke-documentation)
  * [Table of Contents](#table-of-contents)
  * [Requirements](#requirements)
  * [Getting started](#getting-started)
  * [Echo bot](#echo-bot)
  * [Events](#events)
  * [Request Builders](#request-builders)
    * [valid?](#valid)
    * [build_requests](#build_requests)
    * [Order the strategies](#order-the-strategies)
  * [Actions](#actions)
    * [Parameters](#parameters)
  * [Responses](#responses)
    * [Media attachments](#media-attachments)
    * [Buttons](#buttons)
    * [Suggested replies](#suggested-replies)
* [Clarke UI libraries](#clarke-ui-libraries)


## Requirements

* Clarke should be use with at least one [UI library](#clarke-ui-libraries)
* An API should be exposed to handle platform request

## Getting started



## Echo bot

In your routes' code, forward the request body to Clarke
```ruby
# in your API file
require 'clarke'
require 'clarke/platformlib'

post '/platform' do
  request_body = JSON.parse(request.body.read)
  Clarke.process(Clarke::PlatformLibrary, request_body)
end
```

Create a Request Builder that will build an echo request for the text messages you'll receive
```ruby
# text_echo.rb
module Clarke::RequestsBuilder::TextEcho
  class << self
    def valid? (event)
      event.class.include?(Clarke::Events::TextMessage)
    end

    def build_requests (event)
      [Clarke::ActionRequest.new('send_response', event, {response: event.text})]
    end
  end
end
Clarke::RequestsBuilder.config([Clarke::RequestsBuilder::TextEcho])
```

Then add the corresponding action
```ruby
# action.rb
module Clarke::ActionController
  action 'send_response' do
    Clarke::Response.new(options[:event].sender, {text: options[:response]})
  end
end
```
Note: Do not forget to require the Clarke files when initializing your API


## Events

An `Event` represents a request received by the API from the UI platform. It might be either a text message, the action linked to a button, an attachment or meta data about the conversation.
An `Event` object is linked to a UI Platform but it must include a least one of the Clarke module list below

* TextMessage
* Metadata
* Media
* Button

### TextMessage
A text message must respond to the `text` method

### Metadata
No standard attributes implemented.

### Media
No standard attributes implemented.

### Button
No standard attributes implemented.

## Request Builders

The Request Builders are ordered strategies to handle the events your receive.
Each one must expose two methods, `valid?` and `build_requests`.

### valid?
It takes an `Event` as argument and must return `true` if the request builder can handle the event, `false` if not.

### build_requests
It takes an `Event` that the request builder can handle and must return an *array* of actions with the following design:
```ruby
[{
  action: string, #required: the name of the action to execute
  event: Clarke::Event, #required: the Event that triggers the request builder
  response: string, #optional: the response that the action should return
  params: {} #optional: parameters that will be available inside the action code block
}]
```

### Order the strategies
After requiring your strategy files, you must order them in an array and pass it to `Clarke::RequestsBuilder.config`
```ruby
Clarke::RequestsBuilder.config([
  Clarke::RequestsBuilder::StrategieOne,
  Clarke::RequestsBuilder::StrategieTwo,
  Clarke::RequestsBuilder::DefaultStrategie
])
```
Note: It is recommended to include a default strategy at the end that is always valid.


## Actions

In Clarke, an action is a code block that return the responses for a given event. Action declaration must be nested in the `Clarke::ActionController` module.
You must return either a Clarke::Response or an array of Clarke::Response
```ruby
module Clarke::ActionController
  action 'hello_world' do
    Clarke::Response.new(options[:event].sender, {text: 'Hello World!'})
  end
end
```

### Parameters
You can access as the action parameters (event, params and response) through the `options` hash
```ruby
module Clarke::ActionController
  action 'hello' do
    text = "Hello #{options[:params][:name]}"
    Clarke::Response.new(options[:event].sender, {text: text})
  end
end
```

## Responses

A `Clark::Response` is a generic response that can be understand by any UI platform. Only a recipient is required, other attributes are optional
```ruby
response = Clarke::Response.new(sender)
```

Here is a list of the available attributes
* title (String)
* text (String)
* image (Hash)
* audio (Hash)
* video (Hash)
* file (Hash)
* buttons (Array[Buttons])
* suggested_replies (Array[String])
* options (Hash)

### Media attachments
`image`, `audio`, `video` and `file` must be a Hash with the following designed
```ruby
{
  title: string, #optional
  url: string #required
}
```

### Buttons
`buttons` must be an Array of buttons with one of the following designs
```ruby
{
  label: string, #required: the label displayed on the button
  url: string #required: url link to be redirected to
}
```
```ruby
{
  label: string, #required: the label displayed on the button
  action: string #required: the action (postback) to send to the server
}
```

### Suggested replies
`suggested_replies` must be an Array of strings of responses you want to suggest to users

# Clarke UI libraries

[Facebook Messenger](https://github.com/applidium/clarke-messenger/)

# frozen_string_literal: true

require 'json'

module Clarke
  class Response
    attr_accessor :recipient, :title, :text, :image, :audio, :video, :file,
                  :buttons, :suggested_replies, :options

    def initialize(recipient, options = {})
      @recipient = recipient
      @title = options[:title]
      @text = options[:text]
      @image = options[:image]
      @audio = options[:audio]
      @video = options[:video]
      @file = options[:file]
      @buttons = options[:buttons] || []
      @suggested_replies = options[:suggested_replies] || []
      @options = options
    end

    def self.from_json(string)
      data = JSON.parse(string, symbolize_names: true)
      new(data[:recipient], data[:options])
    end

    def to_json(*_args)
      JSON.dump(
        recipient: recipient,
        options: options
      )
    end
  end
end

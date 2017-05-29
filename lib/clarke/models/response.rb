module Clarke
  class Response
    attr_accessor :recipient, :title, :text, :image, :audio, :video, :file,
    :buttons, :suggested_replies, :http_response, :options

    def initialize (recipient, options = {})
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

  end
end

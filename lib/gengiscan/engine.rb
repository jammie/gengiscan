require 'net/http'
require 'nokogiri'

module Gengiscan
  class Engine


    attr_reader :res



    def initialize      
    end

    def detect(url)
      uri = URI(url)
      res = Net::HTTP.get_response(uri)

      {:code=>res.code, :server=>res['Server'], :powered=>res['X-Powered-By'], :generator=>get_generator_signature(res)} 
    end

    private 
    def get_generator_signature(res)

      generator = ""
      doc=Nokogiri::HTML(res.body)
      doc.xpath("//meta[@name='generator']/@content").each do |value|
        generator = value.value
      end

      generator
    end

  end
end

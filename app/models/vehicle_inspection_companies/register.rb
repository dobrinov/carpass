require 'nokogiri'

module VehicleInspectionCompanies
  class Register
    include HTTParty

    base_uri 'rta.government.bg'

    def self.all
      new.all
    end

    def all
      response = self.class.get("/images/Image/registri/AllValidPermitsData.html")
      Rails.logger.info "Performing request to #{response.request.last_uri}"

      case response.code
      when 200
        parse response.body
      else
        Rails.logger.error "#{response.code} #{response.message}"
      end
    end

    private

    def parse(html)
      rows = Nokogiri::HTML(html).xpath('//table/tbody/tr')

      rows.map do |row|
        {
          license: row.at_xpath('td[1]/text()').text,
          company: row.at_xpath('td[2]/text()').text,
          address: row.at_xpath('td[3]/text()').text,
          city:    row.at_xpath('td[4]/text()').text.sub('гр.', ''),
        }
      end
    end
  end
end

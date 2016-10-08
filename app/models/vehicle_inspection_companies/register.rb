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
          license:         license(row),
          company:         company(row),
          address:         address(row),
          settlement:      settlement(row),
          settlement_type: settlement_type(row)
        }
      end
    end

    def license(html)
      html.at_xpath('td[1]/text()').text
    end

    def company(html)
      html.at_xpath('td[2]/text()').text
    end

    def address(html)
      html.at_xpath('td[3]/text()').text
    end

    def settlement(html)
      raw_settlement = html.at_xpath('td[4]/text()').text.
        sub('гр.', '').
        sub('с.', '')

      capitalize_first_letter(raw_settlement)
    end

    def settlement_type(html)
      raw_settlement = html.at_xpath('td[4]/text()').text

      if raw_settlement.include? 'гр'
        Location.settlement_types[:city]
      elsif raw_settlement.include? 'с'
        Location.settlement_types[:village]
      else
        Location.settlement_types[:unknown]
      end
    end

    def capitalize_first_letter(text)
      text.slice(0,1).mb_chars.upcase.to_s + text.slice(1..-1).mb_chars.downcase.to_s
    end
  end
end

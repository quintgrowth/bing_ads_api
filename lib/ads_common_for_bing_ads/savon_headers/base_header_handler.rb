module AdsCommonForBingAds
  module SavonHeaders

    class BaseHeaderHandler

      # Generates SOAP headers with the default request header element.
      def generate_headers(request, soap)
        soap.header.merge!(generate_request_header())
      end

    end
  end
end
# encoding: utf-8
# Helper methods for loading and managing the available services in the Bing Ads API.

require 'bing_ads_api/version'

module BingAdsApi

  # Contains helper methods for loading and managing the available services.
  module ApiConfig

    # Inherit from AdsCommonForBingAds::ApiConfig
    class << ApiConfig
      include AdsCommonForBingAds::ApiConfig
    end

    # Set defaults
    DEFAULT_VERSION = :v9
    DEFAULT_ENVIRONMENT = :PRODUCTION
    LATEST_VERSION = :v9

    # Set other constants
    API_NAME = 'BingAdsApi'
    DEFAULT_CONFIG_FILENAME = 'bing_ads_api.yml'

    # Configure the services available to each version
    @@service_config = {
      :v8 => [
          :AdIntelligenceService,
          :AdministrationService,
          :BulkService,
          :CampaignManagementService,
          :CustomerBillingService,
          :CustomerManagementService,
          :NotificationService,
          :OptimizerService,
          :ReportingService
      ],
      :v9 => [
          :AdIntelligenceService,
          :BulkService,
          :CampaignManagementService,
          :CustomerBillingService,
          :CustomerManagementService,
          :OptimizerService,
          :ReportingService
      ]
    }

    # Configure the different environments, with the base URL for each one
    @@environment_config = {
      :PRODUCTION => {
        :oauth_scope => '',
        :header_ns => 'https://adcenter.microsoft.com/api/adcenter/',
        :v8 => '',
        :v9 => ''
      },
      :SANDBOX => {
        :oauth_scope => '',
        :header_ns => 'https://adcenter.microsoft.com/api/adcenter/',
        :v8 => '',
        :v9 => ''
      }
    }

    # Configure the subdirectories for each version / service pair.
    # A missing pair means that only the base URL is used.
    @@subdir_config = {}

    @@address_config = {
        :v9 => {
          :AdIntelligenceService     => {:PRODUCTION => "https://api.bingads.microsoft.com/Api/Advertiser/AdIntelligence/v9/AdIntelligenceService.svc?wsdl", :SANDBOX => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/AdIntelligence/v9/AdIntelligenceService.svc?wsdl"},
          :BulkService               => {:PRODUCTION => "https://api.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/BulkService.svc?wsdl",           :SANDBOX => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/BulkService.svc?wsdl"},
          :CampaignManagementService => {:PRODUCTION => "https://api.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/CampaignManagementService.svc?wsdl", :SANDBOX => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/CampaignManagement/v9/CampaignManagementService.svc?wsdl"},
          :CustomerBillingService    => {:PRODUCTION => "https://clientcenter.api.bingads.microsoft.com/Api/Billing/v9/CustomerBillingService.svc?wsdl",       :SANDBOX => ""},
          :CustomerManagementService => {:PRODUCTION => "https://clientcenter.api.bingads.microsoft.com/Api/CustomerManagement/v9/CustomerManagementService.svc?wsdl", :SANDBOX => "https://clientcenter.api.sandbox.bingads.microsoft.com/Api/CustomerManagement/v9/CustomerManagementService.svc?wsdl"},
          :OptimizerService          => {:PRODUCTION => "https://api.bingads.microsoft.com/Api/Advertiser/Optimizer/v9/OptimizerService.svc?wsdl",               :SANDBOX => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/Optimizer/v9/OptimizerService.svc?wsdl"},
          :ReportingService          => {:PRODUCTION => "https://api.bingads.microsoft.com/Api/Advertiser/Reporting/v9/ReportingService.svc?wsdl",               :SANDBOX => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/Reporting/v9/ReportingService.svc?wsdl"}
        },
        :v8 => {
          :AdIntelligenceService     => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/CampaignManagement/AdIntelligenceService.svc?wsdl", :SANDBOX => ""},
          :AdministrationService     => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/Administration/AdministrationService.svc?wsdl",     :SANDBOX => ""},
          :BulkService               => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/CampaignManagement/BulkService.svc?wsdl",           :SANDBOX => ""},
          :CampaignManagementService => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/CampaignManagement/CampaignManagementService.svc?wsdl", :SANDBOX => "https://api.sandbox.bingads.microsoft.com/Api/Advertiser/v8/CampaignManagement/CampaignManagementService.svc?wsdl"},
          :CustomerBillingService    => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/Billing/v8/CustomerBillingService.svc?wsdl",       :SANDBOX => ""},
          :CustomerManagementService => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/CustomerManagement/v8/CustomerManagementService.svc?wsdl", :SANDBOX => "https://sharedservices.api.sandbox.bingads.microsoft.com/Api/CustomerManagement/v8/CustomerManagementService.svc?wsdl"},
          :NotificationService       => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/Notification/v8/NotificationService.svc?wsdl",     :SANDBOX => ""},
          :OptimizerService          => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/Optimizer/OptimizerService.svc?wsdl",               :SANDBOX => ""},
          :ReportingService          => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/Reporting/ReportingService.svc?wsdl",               :SANDBOX => ""}
        }
    }

    # Auth constants for ClientLogin method.
    #TODO: remove client_login_config
    @@client_login_config = {
      :AUTH_SERVER => 'https://www.microsoft.com',
      :LOGIN_SERVICE_NAME => 'adcenter'
    }

    public

    # Getters for constants and module variables.
    def self.default_version
      DEFAULT_VERSION
    end

    def self.default_environment
      DEFAULT_ENVIRONMENT
    end

    def self.latest_version
      LATEST_VERSION
    end

    def self.api_name
      API_NAME
    end

    def self.service_config
      @@service_config
    end

    def self.environment_config(environment, key)
      return @@environment_config.include?(environment) ?
          @@environment_config[environment][key] : nil
    end

    def self.address_config
      @@address_config
    end

    def self.subdir_config
      @@subdir_config
    end

    def self.client_login_config(key)
      return @@client_login_config[key]
    end

    def self.default_config_filename
      DEFAULT_CONFIG_FILENAME
    end

    def self.headers_config
      @@headers_config
    end

    # Get the download URL for Ad Hoc reports.
    #
    # Args:
    # - environment: the service environment to be used
    # - version: the API version (as a symbol)
    #
    # Returns:
    # - The endpoint URL (as a string)
    #
    def self.adhoc_report_download_url(environment, version)
      base = get_wsdl_base(environment, version)
      if base
        base += 'reportdownload/%s' % version.to_s
      end
      return base
    end
  end
end

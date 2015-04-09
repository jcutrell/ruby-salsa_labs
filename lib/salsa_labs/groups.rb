module SalsaLabs
  ##
  # Group represents a single member in the Salsa Labs CRM.
  # Standard field list from documentation at
  #   https://help.salsalabs.com/entries/21518315-Standard-supporter-fields-the-supporter-object-
  ##
  class Groups < SalsaObject

    def self.fetch(filter_parameters = {}, credentials = {})
      GroupsFetcher.new(filter_parameters, credentials).fetch
    end

    def self.tagged(tag, filter_parameters={}, credentials = {})
      GroupsFetcher.new(filter_parameters).tagged(tag)
    end

    def tracking_info_blank?
      (self.source_details.blank? && self.source_tracking_code.blank?) || (self.source_details =~ /No Referring info/ &&  self.source_tracking_code =~ /No Original Source/)
    end
  end

  ##
  # GroupsFetcher is a service object to pull back a collection of supporters from the Salsa Labs API.
  ##
  class GroupsFetcher < SalsaObjectsFetcher 
    def initialize(filter_parameters = {}, credentials = {})
      super(filter_parameters, credentials)
      @object_class = SalsaLabs::Groups
    end

    attr_reader :object_class
  end
end

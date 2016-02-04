module ChurchCommunityBuilder

  include Enumerable

  class SavedSearch < ApiObject

    ccb_attr_accessor :id,
                      :name,
                      :last_run,
                      :listed,
                      :creator,
                      :modifier,
                      :created,
                      :modified

    def initialize(json_data = nil, options = {})

      if json_data["ccb_api"].nil?
        saved_search_json = json_data
      else
        saved_search_json = json_data["ccb_api"]["response"]["searches"]["search"]
      end

      initialize_from_json_object(saved_search_json) unless saved_search_json.nil?

    end
  end

end

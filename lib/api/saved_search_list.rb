module ChurchCommunityBuilder

  class SavedSearchList

    include Enumerable

    attr_reader :request_data,
                :response_data,
                :service,
                :count,
                :saved_search_array,
                :json_data #for debugging


    def initialize(json)
      @json_data = json["ccb_api"]
      @request_data = @json_data["request"]
      @response_data = @json_data["response"]
      @service = @response_data["service"] #CCB service type accessed

      @saved_searches  = @response_data['searches']

      @count = @saved_searches["count"].to_i #number of records

      # if @saved_searches['search'] is a single item, it will be returned
      # as a Hash, rather than a single element Array, containing the Hash.
      #
      if @saved_searches["search"].is_a?(Array)
        @saved_search_array = @saved_searches["search"]

      elsif @saved_searches["search"].is_a?(Hash)
        @saved_search_array = []
        @saved_search_array << @saved_searches["search"] #array of each campus
      end

    end

    def all_names
      return [] unless @saved_search_array
      @saved_search_array.collect { |saved_search| saved_search['name'] }
    end

    def ids
      (@saved_search_array.collect { |saved_search| saved_search['id'] }).uniq
    end

    def [](index)
      SavedSearch.new( @saved_search_array[index] ) if @saved_search_array and @saved_search_array[index]
    end


    # This method is needed for Enumerable.
    def each &block
      @saved_search_array.each{ |saved_search| yield( SavedSearch.new(saved_search) )}
    end


    def empty?
      @saved_search_array.size == 0 ? true : false
    end

  end

end

module ChurchCommunityBuilder

  class AttendanceProfileList

    include Enumerable

    attr_reader :request_data,
                :response_data,
                :service_action,
                :events,
                :count,
                :json_data #for debugging

    def initialize(json)
      @json_data = json['ccb_api']
      @request_data = @json_data['request']

      # This is needed for now to account for the two different formats
      @events = if @json_data.has_key?('response')
        @response_data = @json_data['response']
        @response_data['events']
      end
      @events_array = [] and return unless @events
      @count = @events['count'].to_i if @events
      @events_array = @events['event'].class == Array ? @events['event'] : [@events['event']].compact
    end

    def all_names
      return [] unless @events_array
      @events_array.collect { |event| [event['first_name'], event['last_name']].join(' ') }
    end

    def [](index)
      AttendanceProfile.new( @events_array[index] ) if @events_array and @events_array[index]
    end

    # This method is needed for Enumerable.
    def each &block
      @events_array.each{ |event| yield( AttendanceProfile.new(event) )}
    end

    def empty?
      self.count != 0
    end
  end
end

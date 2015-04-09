module SalsaLabs
  ##
  # Object used to translate an attributes hash to API's expected parameter list
  # Deals with weird capitalization
  ##
  class ApiObjectParameterList

    def initialize(attributes)
      @attributes = attributes
      capitalize!
    end

    def capitalize
      capitalized_attributes = {}

      @attributes.each do |key, value|
        #re-capitalize according to Salsa's unique requirements
        key = key.to_s
        value = value.to_s

        #deal with exceptions first
        if ['key','object','tag'].include? key
          #no change, these must not be capitalized
          capitalized_key = key
        elsif key.end_with? '_key'
          #asdf_key -> asdf_KEY
          parts = key.split('_')
          capitalized_key = [parts[0..-2],parts.last.upcase].join('_')
        elsif key == 'mi'
          #middle initial is special case
          capitalized_key = "MI"
        elsif key == 'uid'
          #uid is always lower case
          capitalized_key = 'uid'
        elsif key.start_with? 'private'
          # private_ab_cd_1 -> PRIVATE_Ab_Cd_1
          parts = key.split('_')
          last_parts = parts[1..-1].map{|part| part.capitalize}
          capitalized_key = [parts.first.upcase,last_parts].join('_')
        else
          #all others are capitalized normally
          capitalized_key = (key.split('_').map {|part| part.capitalize}).join('_')
        end

        capitalized_attributes[capitalized_key] = value
      end

      capitalized_attributes
    end

    def capitalize!
      @attributes = capitalize
    end

    attr_reader :attributes
  end

end

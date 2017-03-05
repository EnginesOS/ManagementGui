module Conform
  class AppBlueprint

    def initialize(original_blueprint)
      @original_blueprint = original_blueprint
    end

    def major
      @original_blueprint.dig(:schema, :version, :major).to_i
    end

    def minor
      @original_blueprint.dig(:schema, :version, :minor).to_i
    end

    def schema1_0
      raise BlueprintSchemaVersionError if major > 1 || ( major == 1 && minor > 0 )
      return Schema_0_0ToSchema_1_0.new(@original_blueprint).output if major < 1
      Schema_1_0.new(@original_blueprint).output
    end

  end
end

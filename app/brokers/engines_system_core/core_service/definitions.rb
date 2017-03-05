# module EnginesSystemCore
#   class CoreApp
#     module Definitions
#
#       def type_path
#         @type_path ||=
#           CoreResult.new(:get, api.type_path).call
#       end
#
#       def publisher_namespace
#         @publisher_namespace ||=
#           CoreResult.new(:get, api.publisher_namespace).call
#       end
#
#       def service_definition
#         @service_definition ||=
#           CoreResult.new(:get, api.service_definition).call
#       end
#
#     end
#   end
# end

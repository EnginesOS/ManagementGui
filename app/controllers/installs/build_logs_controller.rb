# module Installs
#   class BuildLogsController < ApplicationController
#
#     include ActionController::Live
#
#     before_action :set_engines_system
#
#     def show
#       response.headers['Content-Type'] = 'text/event-stream'
#       @engines_system.builder_log_stream do |log_line|
#         # broadcast_event installer_builder_log_line(log_line)
#         # randomo = rand 1..100
#         # p "randomo #{randomo}"
#         # break if randomo == 1
#         send_string = "event: engines_builder_event\ndata: #{{type: :log_line, line: log_line}.to_json}\n\n"
#         Rails.logger.info "Send builder event - #{send_string}"
#         response.stream.write(send_string)
#       end
#     ensure
#       response.stream.write("event: engines_builder_event\ndata: #{{type: :log_eof}.to_json}\n\n")
#       response.stream.close
#       Rails.logger.info 'Builder events stream closing'
#     end
#
#   end
# end

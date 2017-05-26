# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Channel < ActionCable::Channel::Base


        # def connections_info
        #     connections_array = []
        #     connection.server.connections.each do |conn|
        #         conn_hash = {}
        #         conn_hash[:current_user] = conn.current_user
        #         conn_hash[:subscriptions_identifiers] = conn.subscriptions.identifiers.map {|k| JSON.parse k}
        #         connections_array << conn_hash
        #     end
        #     connections_array
        # end
        #
        # def user_subscribed?
        #     connection.server.connections.map(&:current_user).include? current_user
        #     #  each do |conn|
        #     #     conn_hash = {}
        #     #     conn_hash[:current_user] = conn.current_user
        #     #     conn_hash[:subscriptions_identifiers] = conn.subscriptions.identifiers.map {|k| JSON.parse k}
        #     #     connections_array << conn_hash
        #     # end
        #     # connections_array
        # end



  end
end

module EnginesSystemCore
  class CoreService
    module Actions

      # def stop
      #   act system_api.stopService
      # end
      #
      # def start
      #   act system_api.startService
      # end
      #
      # def pause
      #   act system_api.pauseService
      # end
      #
      # def unpause
      #   act system_api.unpauseService
      # end
      #
      # def restart
      #   act system_api.restartService
      # end
      #
      # def create
      #   act system_api.createService
      # end
      #
      # def recreate
      #   act system_api.recreateService
      # end

      # {
      #   stop: 'stopService',
      #   start: 'startService',
      #   pause: 'pauseService',
      #   unpause: 'unpauseService',
      #   restart: 'restartService',
      #   create: 'createService',
      #   recreate: 'recreateService'
      # }.
      # each do |method, instruction|
      #   define_method(method) do |options={}|
      #     CoreResult.new(:do,
      #       if options.present?
      #         EnginesSystemCore::CoreSystem.api.send(instruction, name, options)
      #       else
      #         EnginesSystemCore::CoreSystem.api.send(instruction, name)
      #       end
      #     ).call
      #   end
      # end

    end
  end
end

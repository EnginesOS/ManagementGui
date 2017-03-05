module EnginesSystemCore
  class CoreApp
    module Actions

      def stop
        act system_api.stopEngine(name)
      end

      def start
        act system_api.startEngine(name)
      end

      def pause
        act system_api.pauseEngine(name)
      end

      def unpause
        act system_api.unpauseEngine(name)
      end

      def destroy
        act system_api.destroyEngine(name)
      end

      def reinstall
        act system_api.reinstall_engine(name)
      end

      def restart
        act system_api.restartEngine(name)
      end

      def create
        act system_api.createEngine(name)
      end

      def recreate
        act system_api.recreateEngine(name)
      end

      #
      # {
      #   stop: 'stopEngine',
      #   start: 'startEngine',
      #   pause: 'pauseEngine',
      #   unpause: 'unpauseEngine',
      #   destroy: 'destroyEngine',
      #   reinstall: 'reinstall_engine',
      #   restart: 'restartEngine',
      #   create: 'createEngine',
      #   recreate: 'recreateEngine'
      # }.
      # each do |method, instruction|
      #   define_method(method) do |options={}|
      #     CoreResult.new(:do,
      #       if options.present?
      #         EnginesSystemCore::CoreSystem.api.send(instruction, name, options )
      #       else
      #         EnginesSystemCore::CoreSystem.api.send(instruction, name )
      #       end
      #     ).call
      #   end
      # end

    end
  end
end

module Devise
  module Models
    module Lockable
      def lock_access!(opts = { })
        self.locked_at = Time.now
        p self.reason = "Multiple failed login attempts"
        p self.deactivated_on = self.locked_at
        if unlock_strategy_enabled?(:email) && opts.fetch(:send_instructions, true)
          send_unlock_instructions
        else
          save(validate: false)
        end
      end
    end
  end
end
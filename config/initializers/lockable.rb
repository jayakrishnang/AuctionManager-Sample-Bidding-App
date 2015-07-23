module Devise
  module Models
    module Lockable
      def lock_access!(opts = { })
        self.locked_at = Time.now
        self.reason = "Multiple failed login attempts"
        self.deactivated_on = self.locked_at
        self.is_active = :false
        if unlock_strategy_enabled?(:email) && opts.fetch(:send_instructions, true)
          send_unlock_instructions
        else
          save(validate: false)
        end
      end
      def unlock_access!
        self.locked_at = nil
        self.is_active = 1
        self.reason = nil
        self.deactivated_on = nil
        self.failed_attempts = 0 if respond_to?(:failed_attempts=)
        self.unlock_token = nil if respond_to?(:unlock_token=)
        save(validate: false)
      end
    end
  end
end
module DtuRailsCommon
  module UserRoles
    def roles
      return [] unless respond_to? :user_data
      user_data.try(:[], 'applications_and_roles').try(:[], Rails.application.config.try(:app_name)) || []
    end

    def admin?
      roles.include? 'admin'
    end

    def support?
      roles.include? 'support'
    end
  end
end

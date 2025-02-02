class ActiveRecord::AssociatedObject::Railtie < Rails::Railtie
  initializer "integrations.include" do
    ActiveRecord::AssociatedObject.include Kredis::Attributes       if defined?(Kredis)
    ActiveRecord::AssociatedObject.include GlobalID::Identification if defined?(GlobalID)
  end

  initializer "object_association.setup" do
    ActiveSupport.on_load :active_record do
      require "active_record/associated_object/object_association"
      ActiveRecord::Base.extend ActiveRecord::AssociatedObject::ObjectAssociation
    end
  end
end

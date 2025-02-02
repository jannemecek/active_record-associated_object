class ApplicationRecord::AssociatedObject < ActiveRecord::AssociatedObject; end

class Post::Publisher < ApplicationRecord::AssociatedObject
  mattr_accessor :performed,      default: false
  mattr_accessor :captured_title, default: nil

  kredis_datetime :publish_at

  def after_update_commit
    self.captured_title = post.title
  end

  def prevent_errant_post_destroy
    throw :abort
  end

  def publish_later
    PublishJob.perform_later self
  end

  class PublishJob < ActiveJob::Base
    def perform(publisher)
      publisher.performed = true
    end
  end
end

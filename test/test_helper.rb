# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "active_record"
require "active_record/associated_object"
require "logger"

require "minitest/autorun"

active_record::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
active_record::Base.logger = Logger.new(STDOUT)

active_record::Schema.define do
  create_table :posts, force: true do |t|
  end

  create_table :comments, force: true do |t|
    t.integer :post_id
  end
end

class Post < active_record::Base
  has_many :comments
end

class Comment < active_record::Base
  belongs_to :post
end

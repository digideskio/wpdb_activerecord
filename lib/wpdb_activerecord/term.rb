module WPDB
  class Term < ActiveRecord::Base
    self.table_name = "#{WPDB.configuration.prefix}terms"
    self.primary_key = :term_id

    has_one :term_taxonomy, foreign_key: "term_id", class_name: WPDB.configuration.term_taxonomy_class
    has_many :term_taxonomies, foreign_key: "term_id", class_name: WPDB.configuration.term_taxonomy_class

    scope :tag, -> { joins(:term_taxonomy).where("#{WPDB.configuration.term_taxonomy_class.constantize.table_name}.taxonomy = 'post_tag'") }
    scope :category, -> { joins(:term_taxonomy).where("#{WPDB.configuration.term_taxonomy_class.constantize.table_name}.taxonomy = 'category'") }
  end
end

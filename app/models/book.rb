require 'open-uri'

class Book < ActiveRecord::Base
  attr_accessor :cover_url
  has_attached_file :cover, :styles => { :small  => "150x250>" }
  def to_param
    slug = title.strip

    #blow away apostrophes
    slug.gsub! /['`]/,""

    # @ --> at, and & --> and
    slug.gsub! /\s*@\s*/, " at "
    slug.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
    slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

    #convert double underscores to single
    slug.gsub! /_+/,"_"

    #strip off leading/trailing underscore
    slug.gsub! /\A[_\.]+|[_\.]+\z/,""

    "#{id}-#{slug}"
  end

  def copies_remaining
    copies
  end

  private
  def upload_url
    unless cover_url.blank?
      uri = URI.parse cover_url
      file = uri.open
      #TODO this is a HACK
      instance_eval <<-EOF
      def file.original_filename
        '#{File.basename uri.path}'
      end
      EOF
      cover.assign file
    end
  end
  before_validation :upload_url

  validates_attachment_presence :cover

  validates_numericality_of :copies, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :isbn
  validates_presence_of :title
  validates_presence_of :author
end

class Book < ActiveRecord::Base
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
  validates_numericality_of :copies, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :isbn
  validates_presence_of :title
  validates_presence_of :author
end

module Metl::GoldenMaster

  def self.included(base)
    # include Document in the base class
    # define :exposes, :persists, etc
    # add a hook to include the Metl::Document on subclassing
    base.class_eval do 
      class << base
        def exposes(params=nil)
          params.nil? ? @__exposed    ||= [] : exposes << params
        end

        def persists(params=nil)
          params.nil? ? @__persisted  ||= [] : persists << params
        end

        def groups(params=nil)
          params.nil? ? @__groups     ||= [] : persists << params
        end

        def has(params=nil)
          params.nil? ? @__has        ||= [] : persists << params
        end

        def attributes
          (exposes + persists + groups + has).uniq!.sort!
        end
      end
    end
  end
end


# Modules: 
# * Document: An object that persists some cleaned-and-parsed raw data. 
# * GoldenMaster: Some canonical example of a data object that exists across many channels. Is-a Document
# * Channel: Some Ruby Object that generates a "raw" document. Ex: Foursquare::Place::Channel connects to Foursquare
#     and pulls down one raw JSON document and persists it that format.
# * Raw: Non-queryable raw document from a Channel. Has an ID, the lookup params, and the raw text from the channel. 
# * Adapter: An object that converts Raw into a Document.
# * LookupJob: [extract]   .perform creates the Raw
# * ParseJob:  [transform] .perform parses the Raw into a Document
# * PushJob:   [load]      .perofrm pushes the Document's new data into the parent (enqueues a parent class LookupJob)

# module Metl
#   # alias method chain #initialize to log steps taken
#   class Raw
#     def initialize(data)
#       create!(:data => data)
#     end

#     def deserialize(by=nil)
#       # Instead of a case statement, in practice, these will just be parsers
#       # that can register with Metl::Raw. Perhaps automagically when
#       # you subclass Metl::Raw::Parser?
#       case by ||= data.looks_like 
#       when :json: JSON.parse(data)
#       when :xml : XML.parse(data)
#       when :csv : CSV.parse(data)
#       when :flat: CustomParser.parse(data) 
#       else      : data
#     end
#   end

#   module Document
#     # alias method chain #initialize, #save to log steps taken
#     def self.included(base)
#       #add a hook to include Metl::Channel and Metl::Adapter in included Channel and Adapter classes
#       #define each of parent class' :exposes, :persists, :lists, :has
#     end
#     def update!
#       #read each of your attributes from all of your children
#     end
#   end

#   module Channel
#     # alias method chain #initialize, #read and #fetch to log steps taken
#     # must define #connection
#     def read
#       fetch! #must be defined on the channel
#       save!  #write to some generic "channels" collection, persist with an ID
#     end
#   end

#   class LookupJob
#     def self.perform(document_class, document_id)
#       document.channel(params).fetch!
#     end
#   end

#   class ParseJob
#     def self.perform(document_class, document_id)
#       document.raw.deserialize!
#     end
#   end

#   class PushJob
#     def self.perform(document_class, document_id)
#       document.parent.update!
#     end
#   end
# end

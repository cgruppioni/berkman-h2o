class ItemQuestion < ActiveRecord::Base
  include AuthUtilities
  include PlaylistUtilities

  acts_as_authorization_object

  has_one :playlist_item, :as => :resource_item, :dependent => :destroy
  belongs_to :actual_object, :polymorphic => true

  def preview(size_indicator = "S")
#    metadata_hash = get_metadata_hash(self.url)

    preview_content = <<-PREVIEW_CONTENT
       <a href='#{self.url}' target='_blank' class='item_default_link'>Question</a>
    PREVIEW_CONTENT
    
#    preview_content += "<p>\n"
#    preview_content +="<b>Name:</b> #{metadata_hash["title"]}<br />" if metadata_hash["title"].present?
#    preview_content +="<b># of Questions:</b> #{metadata_hash["child_object_count"]}<br />" if metadata_hash["child_object_count"].present?
#    preview_content += "</p>\n"

    return preview_content

  end

end

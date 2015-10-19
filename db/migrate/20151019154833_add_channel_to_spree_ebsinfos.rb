class AddChannelToSpreeEbsinfos < ActiveRecord::Migration
  def change
    add_column :spree_ebsinfos, :channel, :integer
  end
end

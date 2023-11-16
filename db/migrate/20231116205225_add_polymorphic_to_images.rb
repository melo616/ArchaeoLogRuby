class AddPolymorphicToImages < ActiveRecord::Migration[7.0]
  def change
    add_reference :images, :commentable, polymorphic: true
  end
end

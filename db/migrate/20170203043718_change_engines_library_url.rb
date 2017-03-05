class ChangeEnginesLibraryUrl < ActiveRecord::Migration[5.0]

  def up
    Cloud.all.each do |cloud|
      cloud.libraries.first.update(url: 'https://library.engines.org/api/v0/apps')
    end
  end

  def down
    Cloud.all.each do |cloud|
      cloud.libraries.first.update(url: 'https://engineslibrary.engines.onl/api/v0/software')
    end
  end

end

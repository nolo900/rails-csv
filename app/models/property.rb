class Property < ApplicationRecord

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Property.create! row.to_hash
    end
  end

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     property = find_by_id(row["id"]) || new
  #     property.attributes = row.to_hash.slice(:name, :addr1, :addr2, :city, :state, :zip)
  #     property.save!
  #   end
  # end

  def self.export
    my_headers = %w{ id name addr1 addr2 city state zip }
    CSV.generate(headers:true) do |csv|
      csv << my_headers

      all.each do |property|
        csv << property.attributes.values_at(*my_headers)
      end

    end
  end

end
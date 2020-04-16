class CreateDnsRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :dns_records do |t|
      t.string :ip

      t.timestamps
    end
  end
end

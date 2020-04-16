class CreateDnsRecordsHostnames < ActiveRecord::Migration[6.0]
  def change
    create_join_table :dns_records, :hostnames
  end
end

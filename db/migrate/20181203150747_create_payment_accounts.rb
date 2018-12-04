class CreatePaymentAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_accounts do |t|
      t.float :balance, default: 0
      t.string :payment_method_token

      t.references :user

      t.timestamps
    end
  end
end

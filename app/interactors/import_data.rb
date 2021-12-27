class ImportData
  include Interactor::Organizer

  organize ImportShop, ImportCustomers, ImportProducts
end

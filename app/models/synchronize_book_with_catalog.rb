
class SynchronizeBookWithCatalog


  def initialize(book)
    @book = book
  end


  def synchronize!
    @book.oclc_number= catalog_record.oclc_number
    @book.frbr_group_id= catalog_record.frbr_group_id
    @book.number_of_loans= catalog_record.number_of_loans
    @book.title = catalog_record.title
    @book.creator_contributor = catalog_record.creator_contributor
    @book.publisher = catalog_record.publisher_provider

    @book.save!
  end


  private


    def catalog_record
      @catalog_record ||= DiscoveryApi.search_by_id(@book.document_number)
    end


end

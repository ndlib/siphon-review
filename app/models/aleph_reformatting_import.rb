
class AlephReformattingImport

  attr_accessor :import_record

  def initialize(record)
    @original_record = record
    @import_record = import_record
  end


  def import!
    if record_needs_import?
      import_item!
      return true
    end

    return false
  end


  def record_needs_import?
    @import_record.nil?
  end


  def import_item!
    @import_record = ReformattingBook.new(@original_record)
    @import_record.save!

    SynchronizeBookWithCatalog.new(@import_record).synchronize!

    @import_record
  end


  def import_record
    ReformattingBook.by_document_number(@original_record[:document_number])
  end
end

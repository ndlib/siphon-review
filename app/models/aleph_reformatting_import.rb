
class AlephReformattingImport

  attr_accessor :import_record

  def initialize(record)
    @original_record = record
  end


  def import!
    if record_needs_import?
      import_item!
      return true
    else
      update_item!
    end

    return false
  end


  def record_needs_import?
    import_record.nil?
  end

  def update_item!
    import_record.attributes = @original_record
    import_record.save!
  end

  def import_item!
    @import_record = ReformattingBook.new(@original_record)
    SynchronizeBookWithCatalog.new(import_record).synchronize

    import_record.save!

    import_record
  end


  def import_record
    @import_record ||= ReformattingBook.by_unique_id(@original_record[:unique_id])
  end
end

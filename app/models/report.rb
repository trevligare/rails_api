class Report
  def self.create(statement_text: nil, label_id: nil, reporter_uuid: nil, source_id: nil)
    reporter = Reporter.find_or_create_by(
      source_id: source_id,
      uuid: reporter_uuid
    )
    ActiveRecord::Base.transaction do
      statement = Statement.create!(text: statement_text, reporter: reporter)
      Classification.create!(statement_id: statement.id, reporter_id: reporter.id, label_id: label_id ) if label_id
      return statement
    end
  rescue StandardError => exception
    Rails.logger.info exception.inspect
    nil
  end
end

class RecurrenceValidator < ActiveModel::Validator
  def validate(record)
    @recurrence = record.recurrence
    record.errors.add(:recurrence, "is not valid") if monthly_without_frequence?
    record.errors.add(:recurrence, "is not valid") if count_without_frequence?
    record.errors.add(:recurrence, "is not valid") if until_without_frequence?
  end

  private

  def monthly_without_frequence?
    @recurrence.monthly.present? && @recurrence.frequence != "monthly"
  end

  def count_without_frequence?
    @recurrence.count.present? && @recurrence.frequence.blank?
  end

  def until_without_frequence?
    @recurrence.until.present? && @recurrence.frequence.blank?
  end
end
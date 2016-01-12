class RecurrenceValidator < ActiveModel::Validator
  def validate(record)
    @recurrence = record.recurrence
    record.errors.add(:frequence, I18n.t("errors.messages.recurrence.monthly_without_frequence")) if monthly_without_frequence?
    record.errors.add(:frequence, I18n.t("errors.messages.recurrence.count_without_frequence")) if count_without_frequence?
    record.errors.add(:frequence, I18n.t("errors.messages.recurrence.until_without_frequence")) if until_without_frequence?
  end

  private

  def monthly_without_frequence?
    @recurrence.monthly.present? && @recurrence.frequence != "MONTHLY"
  end

  def count_without_frequence?
    @recurrence.count.present? && @recurrence.frequence.blank?
  end

  def until_without_frequence?
    @recurrence.until.present? && @recurrence.frequence.blank?
  end
end

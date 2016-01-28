module DatetimePicker
  extend ActiveSupport::Concern

  included do
    attr_writer :dstart, :tstart, :dend, :tend
  end

  def dend
    @dend || dtend
  end

  def dstart
    @dstart || dtstart
  end

  def tend
    @tend || dtend
  end

  def tstart
    @tstart || dtstart
  end

end

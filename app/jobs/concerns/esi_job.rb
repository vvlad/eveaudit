# frozen_string_literal: true

module EsiJob
  extend ActiveSupport::Concern

  def esi(class_name: nil, **arguments)
    class_name ||= self.class.name.demodulize.remove("Job")
    esi_class = EveOnline::ESI.const_get(class_name)
    esi_class.new(**arguments)
  end
end

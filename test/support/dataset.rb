# frozen_string_literal: true

module Support::Dataset
  extend ActiveSupport::Concern

  def dataset
    @dataset ||= Dataset.new
  end

  module ClassMethods
    def dataset_reader(name, type: :yaml)
      class_eval(<<~RUBY, __FILE__, __LINE__ + 1)
        def #{name}
          @_dataset_#{name} ||= dataset.#{type}(#{name.inspect})
        end
      RUBY
    end
  end

  class Dataset
    def yaml(name)
      YAML.load_file(Rails.root.join("test/datasets/#{name}.yaml"))
    end
  end
end

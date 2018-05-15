module ESISyncing
  extend ActiveSupport::Concern

  included do
    after_create :begin_syncing
  end

  def begin_syncing
    SyncJob.perform_later(self)
  end
end

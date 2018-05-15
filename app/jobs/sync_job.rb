class SyncJob < ApplicationJob
  queue_as :default

  def perform(syncable)
    syncable.sync!
  end
end

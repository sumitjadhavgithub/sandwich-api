class AsyncJob
    include SuckerPunch::Job
    workers 1
  
    def perform(lam)
      ApplicationRecord.connection_pool.with_connection do
        lam.call
      end
    end
  
  end
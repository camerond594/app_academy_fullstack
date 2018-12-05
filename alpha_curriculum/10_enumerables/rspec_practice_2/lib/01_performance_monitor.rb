def measure(num_times = 1, &time)
  start = Time.now
  num_times.times do
    time.call
  end
  finish = Time.now
  diff = (finish - start) / num_times
end

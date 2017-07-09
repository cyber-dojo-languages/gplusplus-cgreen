
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :amber unless /^Completed/.match(output)
  return :red   if /(\d+) failure/.match(output)
  return :red   if /(\d+) exception/.match(output)
  return :green if /(\d+) pass/.match(output)
  return :amber
}

# red
# Completed "HikerTests": 1 pass, 1 failure in 1ms.
# Completed "HikerTests": 2 passes, 2 failures in 1ms.
# Completed "HikerTests": 1 exception in 0ms.
# Completed "HikerTests": 2 exceptions in 1ms.
# Completed "HikerTests": 2 failures, 1 exception in 1ms.
# Completed "HikerTests": 1 pass, 1 failure, 1 exception in 1ms.
# Completed "HikerTests": 2 passes, 2 failures, 2 exceptions in 2ms.

# green
# Completed "HikerTests": 1 pass in 1ms.
# Completed "HikerTests": 4 passes in 1ms.

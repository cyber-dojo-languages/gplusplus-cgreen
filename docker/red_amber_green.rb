
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :red   if / Failure: /.match(output)
  return :red   if / Exception: /.match(output)
  return :green if /0 failures, 0 exceptions/.match(output)
  return :amber
}

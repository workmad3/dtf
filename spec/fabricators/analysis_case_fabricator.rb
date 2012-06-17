Fabricator(:analysis_case) do
  name "DTF Analysis Case"
  description "Fabricated AC for DTF testing"
  verification_suite { Fabricate(:verification_suite) }
  case_tests(count: 3)
end

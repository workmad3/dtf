# encoding: UTF-8

Fabricator(:user) do
  full_name { sequence(:num, 5 ) { |num| "John Q Public #{num}" } }
  email_address { sequence(:email_address, 5) { |num| "jqp#{num}@public.com" } }
  user_name  { sequence(:user_name, 5) { |num| "johnpublic#{num}" } }
end


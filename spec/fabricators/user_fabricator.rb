# -*- coding: UTF-8 -*-

# num = rand(5..10_000_000).to_i.to_s

Fabricator(:user) do
  full_name { sequence(:num, 5 ) { |num| "John Q Public #{num}" } }
  email_address { sequence(:email_address, 5) { |num| "jqp#{num}@public.com" } }
  user_name  { sequence(:user_name, 5) { |num| "johnpublic#{num}" } }
end

